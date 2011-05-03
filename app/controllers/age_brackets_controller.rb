class AgeBracketsController < ApplicationController
  # GET /age_brackets
  # GET /age_brackets.xml
  def index
    @age_brackets = AgeBracket.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @age_brackets }
    end
  end

  # GET /age_brackets/1
  # GET /age_brackets/1.xml
  def show
    @age_bracket = AgeBracket.find(params[:id])
    @games = @age_bracket.games.where(:published => true).paginate(:page => params[:page], :per_page => 5)
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @games }
    end
  end

  # GET /age_brackets/new
  # GET /age_brackets/new.xml
  def new
    @age_bracket = AgeBracket.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @age_bracket }
    end
  end

  # GET /age_brackets/1/edit
  def edit
    @age_bracket = AgeBracket.find(params[:id])
  end

  # POST /age_brackets
  # POST /age_brackets.xml
  def create
    @age_bracket = AgeBracket.new(params[:age_bracket])

    respond_to do |format|
      if @age_bracket.save
        format.html { redirect_to(@age_bracket, :notice => 'Age bracket was successfully created.') }
        format.xml  { render :xml => @age_bracket, :status => :created, :location => @age_bracket }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @age_bracket.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /age_brackets/1
  # PUT /age_brackets/1.xml
  def update
    @age_bracket = AgeBracket.find(params[:id])

    respond_to do |format|
      if @age_bracket.update_attributes(params[:age_bracket])
        format.html { redirect_to(@age_bracket, :notice => 'Age bracket was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @age_bracket.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /age_brackets/1
  # DELETE /age_brackets/1.xml
  def destroy
    @age_bracket = AgeBracket.find(params[:id])
    @age_bracket.destroy

    respond_to do |format|
      format.html { redirect_to(age_brackets_url) }
      format.xml  { head :ok }
    end
  end
end
