class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_item 

  def index
    @purchase_form = PurchaseForm.new
  end

  def create
    binding.pry 
    @purchase_form = PurchaseForm.new(purchase_params)
  
    if @purchase_form.valid?
      @purchase_form.save
      redirect_to root_path
    else
      render :index, status: :unprocessable_entity
    end
  end

  private

  def set_item
    @item = Item.find(params[:item_id])  # item_id を取得
  end

  def purchase_params
    params.require(:purchase_form).permit(
      :postal_code, :prefecture_id, :city, :address, 
      :building_name, :phone_number
    ).merge(user_id: current_user.id, item_id: params[:item_id], token: params[:token])
  end
end
