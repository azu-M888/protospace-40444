class UsersController < ApplicationController

  before_action :authenticate_user!, except: [:show]
  def show
    @user = User.find(params[:id])
    @prototypes = @user.prototypes
  end

  private

  def user_params
    params.require(:user).permit(:name, :email,:password,:profile,:occupation,:position)
  end
end
