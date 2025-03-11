class OrdersController < ApplicationController
  before_action :authenticate_user!

  def index
    @purchase_form = PurchaseForm.new
  end

  def create
    
  end
end
