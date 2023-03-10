class StatsEngine
  # Called every 30 minutes for accurate stats
  def self.run_daily(date = Date.today)
    Time.zone = "UTC"

    today_stat = Stat.find_or_create_by(end_date: date)
    today_stat.initialize_total_with_zero_if_needed

    today_stat.total_revenue = Purchase.where(status: "CAPTURED").where("created_at >= ? AND created_at <= ?", date.beginning_of_day, date.end_of_day).sum(:amount)
    today_stat.total_spent = Cost.where(day: date).sum(:amount)
    today_stat.total_profit = today_stat.total_revenue - today_stat.total_spent
    if today_stat.total_revenue > 0
      today_stat.roi = today_stat.total_profit / today_stat.total_spent * 100
    elsif today_stat.total_revenue == 0 && today_stat.total_spent > 0
      today_stat.roi = -100
    end
    today_stat.total_views = Post.sum(:views) - Stat.sum(:total_views)
    today_stat.total_posts = Post.count - Stat.sum(:total_posts)
    today_stat.validating_posts = Post.where(is_active: 0).count - Stat.sum(:validating_posts)
    today_stat.banned_posts = Post.where(is_active: -1).count - Stat.sum(:banned_posts)
    today_stat.active_posts = Post.where(is_active: 1).count - Stat.sum(:active_posts)
    today_stat.sold_not_shipped_posts = Post.where(is_active: -2).count - Stat.sum(:sold_not_shipped_posts)
    today_stat.sold_shipped_posts = Post.where(is_active: -3).count - Stat.sum(:sold_shipped_posts)
    today_stat.total_transactions = Purchase.where(status: "CAPTURED").where("created_at >= ? AND created_at <= ?", date.beginning_of_day, date.end_of_day).count

    today_stat.save
  end

  # Called hourly, used when date filters are not present on the page
  # Not used
  def self.run_total
    Time.zone = "UTC"
    
    total_stat = Stat.find_or_create_by(period: "grand-total")

    total_stat.total_revenue = Stat.where(period: "daily-total").sum(:total_revenue)
    total_stat.total_spent = Stat.where(period: "daily-total").sum(:total_spent)
    total_stat.total_profit = Stat.where(period: "daily-total").sum(:total_profit)
    if total_stat.total_revenue > 0
      total_stat.roi = total_stat.total_profit / total_stat.total_spent * 100
    elsif total_stat.total_revenue == 0 && total_stat.total_spent > 0
      total_stat.roi = -100
    end
    total_stat.total_views = Stat.where(period: "daily-total").sum(:total_views)
    total_stat.total_posts = Stat.where(period: "daily-total").sum(:total_posts)
    total_stat.validating_posts = Stat.where(period: "daily-total").sum(:validating_posts)
    total_stat.banned_posts = Stat.where(period: "daily-total").sum(:banned_posts)
    total_stat.active_posts = Stat.where(period: "daily-total").sum(:active_posts)
    total_stat.sold_not_shipped_posts = Stat.where(period: "daily-total").sum(:sold_not_shipped_posts)
    total_stat.sold_shipped_posts = Stat.where(period: "daily-total").sum(:sold_shipped_posts)
    total_stat.total_transactions = Stat.where(period: "daily-total").sum(:total_transactions)

    total_stat.save
  end

  # Called every 30 minutes for accurate stats
  def self.run_users(date = Date.today)
    Time.zone = "UTC"

    User.where(archived: false, role: "normal").find_each do |user|
      user_stat = Stat.find_or_create_by(user_id: user.id)
      user_stat.initialize_user_with_zero_if_needed

      user_stat.user_views = user.posts.sum(:views)
      user_stat.followers = user.followers.count
      user_stat.following = user.following.count
      user_stat.user_posts = user.posts.count
      user_stat.user_revenue = Purchase.where(seller_id: user.id).sum(:amount)
      user_stat.user_spent = Purchase.where(buyer_id: user.id).sum(:amount)

      user_stat.save
    end
  end

  # Called hourly, used for total stats
  def self.run_users_total
    Time.zone = "UTC"

    total_stat = Stat.find_or_create_by(period: "user-grand-total")

    total_stat.user_views = Stat.where(period: "user-total").sum(:user_views)
    total_stat.user_posts = Stat.where(period: "user-total").sum(:user_posts)
    total_stat.user_revenue = Stat.where(period: "user-total").sum(:user_revenue)
    total_stat.user_spent = Stat.where(period: "user-total").sum(:user_spent)

    total_stat.save
  end
end