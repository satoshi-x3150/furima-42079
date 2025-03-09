class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]
  # before_action :authenticate_user!, except: [:index, :show]

  def index
    @items = Item.all.order(created_at: :desc)
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path, notice: '商品を出品しました。'
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def item_params
    params.require(:item).permit(
      :name, :description, :price, :image,
      :category_id, :condition_id, :shipping_fee_id,
      :prefecture_id, :shipping_time_id
    ).merge(user_id: current_user.id)
  end

end
