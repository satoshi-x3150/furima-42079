class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_item 
  before_action :redirect_if_sold_out  # 売却済みならトップページにリダイレクト
  before_action :redirect_if_seller # 出品者が購入しようとしたらリダイレクト

  def index
    gon.public_key = ENV["PAYJP_PUBLIC_KEY"]
    @purchase_form = PurchaseForm.new
  end

  def create
    @purchase_form = PurchaseForm.new(purchase_params)
  
    if @purchase_form.valid?
      pay_item
      @purchase_form.save
      return redirect_to root_path
    else
      gon.public_key = ENV["PAYJP_PUBLIC_KEY"]
      render :index, status: :unprocessable_entity
    end
  end

  private

  def set_item
    @item = Item.find(params[:item_id])  # item_id を取得
  end

  def redirect_if_sold_out
    redirect_to root_path if @item.purchase_record.present?
  end

  def redirect_if_seller
    redirect_to root_path if current_user == @item.user
  end

  def purchase_params
    params.require(:purchase_form).permit(
      :postal_code, :prefecture_id, :city, :address, 
      :building_name, :phone_number
    ).merge(user_id: current_user.id, item_id: params[:item_id], token: params[:token])
  end

  def pay_item
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
    Payjp::Charge.create(
      amount: @item.price,              # 商品の値段
      card: purchase_params[:token],    # カードトークン
      currency: 'jpy'                   # 通貨の種類（日本円）
    )
  end
end
