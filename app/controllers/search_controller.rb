class SearchController < ApplicationController
  def search
    @results = Game.search params[:query], :with_all => {:user_ids => params[:user_ids], :category_ids => params[:category_ids]}
  end
  def add_advanced
    @users = User.all
    @categories = Category.roots
  end
end
