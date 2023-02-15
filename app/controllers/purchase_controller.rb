class PurchaseController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :authenticate_user!

  def index
    if params[:submitButton] == "Complete Purchase"
      card_number = params[:card_number].delete(' ')
      if card_number != 16
        redirect_back(fallback_location: checkout_path(post_id: params[:post_id]), alert: "Error - The card number needs to have exactly 16 digits.")
      end

      county = Location.where(short: params[:county]).first.name

      # TODO call function to process the payment
    end
  end
end
