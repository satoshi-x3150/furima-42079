class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  before_action :set_item, only: [:show, :edit, :update, :destroy]
  before_action :move_to_index, only: [:edit, :update, :destroy]
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

  def show
    @item = Item.includes(:purchase_record).find(params[:id])
  end

  def edit
  end

  def update
    if @item.update(item_params)
      redirect_to item_path(@item), notice: '商品情報を更新しました'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    if current_user == @item.user
      @item.destroy
    end
    redirect_to root_path    
  end

  private

  def item_params
    params.require(:item).permit(
      :name, :description, :price, :image,
      :category_id, :condition_id, :shipping_fee_id,
      :prefecture_id, :shipping_time_id
    ).merge(user_id: current_user.id)
  end

  def set_item
    @item = Item.find(params[:id])
  end

  # def move_to_index
  #   # ログインしているユーザーが商品出品者でない場合、トップページへリダイレクト
  #   unless current_user == @item.user
  #     redirect_to root_path
  #   end
  # end
  def move_to_index
    if current_user != @item.user
      redirect_to root_path
    end
  end
end
