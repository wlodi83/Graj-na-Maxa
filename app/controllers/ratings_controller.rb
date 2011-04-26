class RatingsController < ApplicationController
  before_filter :authenticate_user!

  def create
    @game = Game.find_by_id(params[:game_id])
    if current_user.ratings.find_by_game_id(@game.id) 
      respond_to do |format|
      format.html { redirect_to game_path(@game), :notice => 'You canot rate for your own game' }
      format.js
      end
    else
      @rating = Rating.new(params[:rating])
      @rating.game_id = @game.id
      @rating.user_id = current_user.id
      if @rating.save
        respond_to do |format|
          format.html { redirect_to game_path(@game), :notice => 'Your rating has been saved' }
          format.js
        end
      end
    end
  end
  
  def update
    @game = Game.find_by_id(params[:game_id])
    if current_user.id == @game.id
      redirect_to game_path(@game), :alert => "You cannot rate for your own game"
    else
      @rating = current_user.ratings.find_by_game_id(@game.id)
      if @rating.update_attributes(params[:rating])
        respond_to do |format|
          format.html { redirect_to game_path(@game), :notice => "Your rating has been updated" }
          format.js
        end
      end
    end
  end
end
