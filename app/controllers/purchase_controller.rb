class PurchaseController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :authenticate_user!

  def index
    # TODO transform params[:county] back from short to name
    # TODO check that CVV is 3 digits and card number is 16 digits
  end
end
