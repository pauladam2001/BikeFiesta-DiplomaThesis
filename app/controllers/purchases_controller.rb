class PurchasesController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :authenticate_user!

  def index
    @purchases = Purchase.order(created_at: :desc)
  end

  def checkout
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

  # ActiveMerchant::Billing::Base.mode = :test
  # gateway = ActiveMerchant::Billing::PaypalGateway.new(
  #   :login => ENV['PAYPAL_LOGIN'],
  #   :password => ENV['PAYPAL_PASSWORD],
  #   :signature => ENV['PAYPAL_SIGNATURE']
  # )
  # credit_card = ActiveMerchant::Billing::CreditCard.new(
  #   :brand               => "visa",
  #   :number             => ENV['PAYPAL_TEST_CARD_NUMBER'],
  #   :verification_value => "123",
  #   :month              => 3,
  #   :year               => 2028,
  #   :first_name         => "John",
  #   :last_name          => "Doe"
  # )
  # if credit_card.valid?
  #   # or gateway.purchase to do both authorize and capture
  #   response = gateway.authorize(1000, credit_card, :ip => "127.0.0.1")
  #   if response.success?
  #     gateway.capture(1000, response.authorization)
  #     puts "Purchase complete!"
  #   else
  #     puts "Error: #{response.message}"
  #   end
  # else
  #   puts "Error: credit card is not valid. #{credit_card.errors.full_messages.join('. ')}"
  # end
  # response = gateway.purchase(1000, credit_card, :ip => "127.0.0.1")
  # gateway.void(response.authorization)
  # gateway.credit(1000, response.authorization)
  # transfer = gateway.transfer(
  #   1000, 'sb-3orv825105929@personal.example.com', :subject => "The money I owe you", :note => "Sorry it's so late"
  # )
    
end
