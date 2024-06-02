class PrototypesController < ApplicationController
  before_action :move_to_index, except: [:index, :show]
  before_action :authenticate_user!

  def index
    @prototypes = Prototype.all
  end

  def show
    @prototype = Prototype.find(params[:id])
    @comments = @prototype.comments
    @comment = Comment.new
  end

  def new
    @prototype = Prototype.new
  end

  def create
    Prototype.create(prototype_params)
    redirect_to '/'
  end

  def edit
    @prototype = Prototype.find(params[:id])
  end

  def update
    @prototype = Prototype.find(params[:id])
  
    if @prototype.update(prototype_params)
      redirect_to root_path
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @prototype = Prototype.find(params[:id])
    @prototype.destroy
    redirect_to root_path
  end


  private

  def prototype_params
    params.require(:prototype).permit(:title,:catch_copy,:concept,:image).merge(user_id: current_user.id)
  end
  
  def move_to_index
    unless user_signed_in?
      redirect_to action: :index
    end
  end
end
