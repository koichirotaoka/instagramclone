class PicturesController < ApplicationController
  before_action :set_picture, only: [:show, :edit, :update, :destroy]
  before_action :login_ck, only: [:index, :new, :edit, :show, :destroy]
  before_action :login_ck2, only: [:edit, :destroy]
  
  def index
    @pictures = Picture.all
  end
  
  def new
    if params[:back]
      @picture = Picture.new(picture_params)
    else
      @picture = Picture.new
    end
  end
  
  def show
    @favorite = current_user.favorites.find_by(picture_id: @picture.id)
  end

  def create
    @picture = Picture.new(picture_params)
    @picture.user_id = current_user.id 
    if @picture.save
      redirect_to pictures_path, notice: 'Complete！'
    else
      render 'new'
    end
  end
  
  def confirm
    @picture = Picture.new(picture_params)
    @picture.user_id = current_user.id
    render :new if @picture.invalid?
  end
  
  def destroy
    @picture.destroy
    redirect_to pictures_path, notice:"投稿を削除しました！"
  end
  
  def edit
    @picture = Picture.find(params[:id])
  end
  
  def update
    @picture = Picture.find(params[:id])
    if @picture.update(picture_params)
      redirect_to pictures_path, notice: "投稿を編集しました！"
    else
      render 'edit'
    end
  end
  
  private
  
  def picture_params
    params.require(:picture).permit(:content, :image, :image_cache, :user_id)
  end
  
  def set_picture
    @picture = Picture.find(params[:id])
  end
  
  #ログインチェック
  def login_ck
    unless current_user
      flash[:notice] = '失敗しました'
      render new_session_path
    end
  end
  
  def login_ck2
    unless @picture.user_id==current_user.id
      binding.pry
      flash[:notice] = '失敗しました'
      render new_session_path
    end
  end
  
end


