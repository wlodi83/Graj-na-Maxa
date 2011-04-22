class UsersController < ApplicationController
  before_filter :authenticate_user!, :only => [:index, :show, :add_admin, :remove_admin]
  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end
   
  def add_admin
    @user = User.find(params[:id])
    @user.update_attribute :admin, true
    respond_to do |format|
      format.js { @user }
    end
  end
 
  def remove_admin
    @user = User.find(params[:id])
    @user.update_attribute :admin, false
    respond_to do |format|
      format.js { @user }
    end
  end
end
