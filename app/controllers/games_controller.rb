class GamesController < ApplicationController
  uses_tiny_mce
  before_filter :authenticate_user!, :only => [:new, :create, :update, :edit, :destroy, :admin, :list_your_games]
  def notify_friend
    @game = Game.find(params[:id])
    Notifier.email_friend(@game, params[:name], params[:email]).deliver
    redirect_to @game, :notice => "Successfully sent a message to your friend"
  end
  def tag
    @games = Game.tagged_with(params[:id])
    @tags = Game.tag_counts_on(:tags)
    render :action => 'index'
  end
  def index
   if params[:category_id]
   category = Category.find(params[:category_id])
   @games = category.games.where(:published => true).paginate(:page => params[:page], :per_page => 5)
    respond_to do |format|
      format.html #index.html.erb
      format.xml { render :xml => @games }
    end
   else
   @games = Game.where(:published => true).paginate(:page => params[:page], :per_page => 5)
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @games }
    end
   end
  end

  def admin
    if current_user.try(:admin?)
    @games = Game.order("published_at")

    respond_to do |format|
      format.html # admin.html.erb
      format.xml { render :xml => @games }
    end
    else
    redirect_to root_path, :notice => 'You cannot view this pages'  
    end
  end

  def list_your_games
    if current_user
    @games = current_user.games.order("published_at")

    respond_to do |format|
      format.html #list_your_video
      format.xml { render :xml => @games }
    end
    else
    redirect_to new_user_session_path, :notice => 'You must login to show your added games'
    end
  end
  def show
    #@video = Video.find_by_id_and_published(params[:id], true)
    @game = Game.find(params[:id])
    Game.increase_hits_counter(@game.id)
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @game }
    end
  end
  def new
    @game = Game.new
    @author = Author.new
    @game.photos.build
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @game }
    end
  end
  def edit
    if current_user.try(:admin?)
     @game = Game.find(params[:id])
     @author = @game.author
     @game.photos.build
     respond_to do |format|
       format.html #edit.html.erb
       format.xml { render :xml => @game }
     end
    else
     @game = current_user.games.find(params[:id])
     @author = @game.author     
     @game.photos.build
     respond_to do |format|
      format.html #edit.html.erb
      format.xml { render :xml => @game} 
    end
    end
  end
  def create
    @game = current_user.games.new(params[:game])
    @author = Author.new(params[:author])
    @game.author = @author
    Game.set_hits_counter(@game.id)
    respond_to do |format|
      if @game.save and @author.save
        format.html { redirect_to(@game, :notice => 'Game was successfully created.') }
        format.xml  { render :xml => @game, :status => :created, :location => @game }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @game.errors, :status => :unprocessable_entity }
      end
    end
  end
  def update
    @game = Game.find(params[:id])
    @author = @game.author
    respond_to do |format|
      if @game.update_attributes(params[:game]) and @author.update_attributes(params[:author])
        format.html { redirect_to(@game, :notice => 'Game was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @game.errors, :status => :unprocessable_entity }
      end
    end
  end
  def destroy
    @game = Game.find(params[:id])
    @game.destroy

    respond_to do |format|
      format.html { redirect_to(games_admin_url, :notice => 'Game was successfully delete.') }
      format.xml  { head :ok }
    end
  end
end
