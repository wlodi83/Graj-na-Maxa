class SubscriptionsController < ApplicationController
  def index
    @categories = Category.roots
  end
  def add_subscription
    @subscription = Category.find(params[:id])
    current_user.categories << @subscription
    respond_to do |format|
      format.js { @subscription }
    end
  end
  def remove_subscription
    @subscription = Category.find(params[:id])
    current_user.categories.delete(@subscription)
    respond_to do |format|
      format.js { @subscription }
    end
  end
end
