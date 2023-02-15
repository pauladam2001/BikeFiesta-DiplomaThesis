class PurchaseController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :authenticate_user!

  def index
    if params[:submitButton] == "Complete Purchase"
      card_number = params[:card_number].delete(' ')
      if !card_number.scan(/\D/).empty? || card_number.length != 16
        redirect_back(fallback_location: checkout_path(post_id: params[:post_id]), alert: "Error - The Card Number needs to have exactly 16 digits.")
        return
      end

      zip_code = params[:zip_code]
      if !zip_code.scan(/\D/).empty?
        redirect_back(fallback_location: checkout_path(post_id: params[:post_id]), alert: "Error - The Zip Code should contain only digits.")
        return
      end

      cvv = params[:card_cvc]
      if !cvv.scan(/\D/).empty?
        redirect_back(fallback_location: checkout_path(post_id: params[:post_id]), alert: "Error - The CVV should contain only digits.")
        return
      end

      card_year = params[:card_year].to_i
      card_month = params[:card_month].to_i
      if card_year == Time.now.year % 100 && card_month < Time.now.month
        redirect_back(fallback_location: checkout_path(post_id: params[:post_id]), alert: "Error - The Card is expired.")
        return
      end

      county = Location.where(short: params[:county]).first.name

      # TODO call function to process the payment
    end
  end
end
