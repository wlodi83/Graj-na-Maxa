module GamesHelper
include ActsAsTaggableOn::TagsHelper
def rating_ballot
  if @rating = current_user.ratings.find_by_game_id(params[:game_id])
     @rating
  else
     current_user.ratings.new
  end
end

def current_user_rating
  if params[:id] and @rating = current_user.ratings.find_by_game_id(params[:id])
     @rating.value
  elsif params[:game_id] and @rating = current_user.ratings.find_by_game_id(params[:game_id])
     @rating.value
  else
    "You do not vote. Please vote fo your game."
  end
end
end
