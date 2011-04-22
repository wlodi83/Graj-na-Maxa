class CommentsController < ApplicationController
  before_filter :load_game, :except => [:index, :destroy]
  before_filter :authenticate_user!, :only => [:destroy, :index]

  def index
   if current_user.try(:admin?)
   @comments = Comment.all
   respond_to do |format|
     format.html #index.html.erb
     format.xml { render :xml => @comments }
   end
   else
   redirect_to new_user_session_path, :notice => 'You must be an administrator to see this page' 
   end
  end
  def create
    @comment = @game.comments.new(params[:comment])
    if @comment.save
      redirect_to @game, :notice => 'Thanks for your comment'
    else
      redirect_to @game, :alert => 'Unable to add comment'
    end
  end
  
  def destroy
    if current_user.try(:admin?)
    @comment = Comment.find(params[:id])
    @comment.destroy
    redirect_to comments_path, :notice => 'Comments deleted'
    else
    redirect_to root_url, :notice => 'You must be an administrator to delete comment'
    end
  end

  private
  
  def load_game
    @game = Game.find(params[:game_id])
  end
  
end
