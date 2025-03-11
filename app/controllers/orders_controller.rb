class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_item  # `@item` をセット

  def index
    @purchase_form = PurchaseForm.new
  end

  def create
  end

  private

  def set_item
    @item = Item.find(params[:item_id])  # item_id を取得
  end
end
