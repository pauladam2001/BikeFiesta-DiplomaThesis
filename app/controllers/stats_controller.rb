class StatsController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :authenticate_user!, :check_permissions

  def index
    @start_date, @end_date = nil, nil
    @start_date = params[:start_date].to_date if params[:start_date].present? && params[:start_date] != "all"
    @end_date = params[:end_date].to_date if params[:end_date].present? && params[:end_date] != "all"
    
    @stats = Stat.where(period: "daily-total").order(end_date: :desc)

    if @start_date.present?
      @stats = @stats.where("end_date >= ?", @start_date)
    end
    if @end_date.present?
      @stats = @stats.where("end_date <= ?", @end_date)
    end

    @total_stats = {
      total_revenue: @stats.sum(:total_revenue),
      total_spent: @stats.sum(:total_spent),
      total_profit: @stats.sum(:total_profit),
      total_views: @stats.sum(:total_views),
      total_posts: @stats.sum(:total_posts),
      total_transactions: @stats.sum(:total_transactions),
      validating_posts: @stats.sum(:validating_posts),
      banned_posts: @stats.sum(:banned_posts),
      active_posts: @stats.sum(:active_posts),
      sold_not_shipped_posts: @stats.sum(:sold_not_shipped_posts),
      sold_shipped_posts:@stats.sum(:sold_shipped_posts)
    }
    if @total_stats[:total_revenue] > 0
      @total_stats[:roi] = @total_stats[:total_profit] / @total_stats[:total_spent] * 100
    elsif @total_stats[:total_revenue] == 0 && @total_stats[:total_spent] > 0
      @total_stats[:roi] = -100
    end

    @days = []
    if @start_date.present? && @end_date.present?
      (@start_date..@end_date).each do |day|
        @days << day.strftime("%d/%m/%y")
      end
    end
    
    # @line_chart_data = [
    #   {name: "Revenue", data: @stats.collect { |s| [s.end_date, (s.total_revenue).round(2)]}},
    #   {name: "Cost", date: @stats.collect { |s| [s.end_date, (s.total_spent).round(2)]}},           # this was for chartkick
    #   {name: "Profit", date: @stats.collect { |s| [s.end_date, (s.total_profit).round(2)]}}
    # ]
    @line_chart_data = [
      {name: "Revenue", data: @stats.pluck(:total_revenue)},
      {name: "Cost", data: @stats.pluck(:total_spent)},
      {name: "Profit", data: @stats.pluck(:total_profit)},
      {name: "ROI", data: @stats.pluck(:roi)}
    ]
    @line_chart_data.each do |row|
      if row[:data].present?
        max_pos = row[:data].each_with_index.max[1]
        min_pos = row[:data].each_with_index.min[1]

        row[:data][max_pos] = {y: row[:data][max_pos], id: "max-#{row[:name]}"}
        row[:data][min_pos] = {y: row[:data][min_pos], id: "min-#{row[:name]}"}
      end
    end
    
    respond_to do |format|
      format.xlsx do
        render xlsx: 'stats', template: 'stats/stats'
      end
      format.html
    end
  end

  def leaderboard
    require 'will_paginate/array'
    
    @user_stats = Stat.where(period: "user-total")
    @total_stats = Stat.where(period: "user-grand-total").first

    if params[:archived].present?
      @user_stats = @user_stats.joins(:user).where("users.archived = ?", params[:archived])
      @users = User.where(role: "normal", archived: params[:archived]).order(:full_name).pluck(:full_name, :id)
    else
      @user_stats = @user_stats.joins(:user).where("users.archived = false")
      @users = User.where(role: "normal", archived: false).order(:full_name).pluck(:full_name, :id)
    end

    @user_stats = @user_stats.where(user_id: params[:user]) if params[:user].present? && params[:user] != "all"

    if params[:rank_by].present?
      if params[:rank_by] == "revenue"
        @user_stats = @user_stats.sort_by { |stat| stat.user_revenue }.reverse
      elsif params[:rank_by] == "spent"
        @user_stats = @user_stats.sort_by { |stat| stat.user_spent }.reverse
      elsif params[:rank_by] == "posts"
        @user_stats = @user_stats.sort_by { |stat| stat.user_posts }.reverse
      elsif params[:rank_by] == "views"
        @user_stats = @user_stats.sort_by { |stat| stat.user_views }.reverse
      elsif params[:rank_by] == "followers"
        @user_stats = @user_stats.sort_by { |stat| stat.followers }.reverse
      elsif params[:rank_by] == "following"
        @user_stats = @user_stats.sort_by { |stat| stat.following }.reverse
      end
    else
      @user_stats = @user_stats.sort_by { |stat| stat.user_revenue }.reverse
    end

    @user_stats = @user_stats.paginate(page: params[:page], per_page: 12)

    respond_to do |format|
      format.xlsx do
        render xlsx: 'leaderboard', template: 'stats/leaderboard'
      end
      format.html
    end
  end

  private
    def check_permissions
      redirect_to posts_path and return if current_user.is_normal?
    end
end
