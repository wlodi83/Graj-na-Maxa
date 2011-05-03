class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :load_categories, :load_age_brackets
  def initialize
    super
    @tags = Game.tag_counts_on(:tags)
  end
  def load_categories
    @categories = Category.roots
  end
  def load_age_brackets
    @age_brackets = AgeBracket.all
  end
  private
  def after_sign_out_path_for(resource_or_scope)
    root_path
  end
end
