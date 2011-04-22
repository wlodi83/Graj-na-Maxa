class GameObserver < ActiveRecord::Observer
 def after_create(game)
   @users = User.select("distinct user_id, email").joins(:categories).where('category_id IN (?)', game.category_ids)
   @users.each do |user|
     Notifier.game_added(game, user).deliver
   end
 end
end
