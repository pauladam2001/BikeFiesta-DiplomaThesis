class StatsController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :authenticate_user!, :check_permissions

  def index
    @start_date, @end_date = nil, nil
    @start_date = params[:start_date].to_date if params[:start_date].present? && params[:start_date] != "all"
    @end_date = params[:end_date].to_date if params[:end_date].present? && params[:end_date] != "all"
    
    @stats = Stat.where(period: "daily-total")

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

    @line_chart_data = [
      {name: "Revenue", data: @stats.collect { |s| [s.end_date, (s.total_revenue).round(2)]}},
      {name: "Cost", date: @stats.collect { |s| [s.end_date, (s.total_spent).round(2)]}},
      {name: "Profit", date: @stats.collect { |s| [s.end_date, (s.total_profit).round(2)]}}
    ]
  end

  private
    def check_permissions
      redirect_to posts_path and return if current_user.is_normal?
    end
end
