class Stat < ApplicationRecord
  belongs_to :user, foreign_key: :user_id, optional: true

  def initialize_total_with_zero_if_needed
    self.period ||= "daily-total"
    self.total_revenue ||= 0.0
    self.total_spent ||= 0.0
    self.total_profit ||= 0.0
    self.roi ||= 0.0
    self.total_views ||= 0
    self.total_posts ||= 0
    self.validating_posts ||= 0
    self.banned_posts ||= 0
    self.active_posts ||= 0
    self.sold_not_shipped_posts ||= 0
    self.sold_shipped_posts ||= 0
    self.total_transactions ||= 0
  end

  def initialize_user_with_zero_if_needed
    self.period ||= "user-total"
    self.user_views ||= 0
    self.followers ||= 0
    self.following ||= 0
    self.user_posts ||= 0
    self.user_revenue ||= 0.0
    self.user_spent ||= 0.0
  end
end
