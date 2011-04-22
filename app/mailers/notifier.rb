class Notifier < ActionMailer::Base
  default :from => "from@example.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.notifier.email_friend.subject
  #
  def email_friend(game, sender_name, receiver_email)
    @game = game
    @sender_name = sender_name
    @photo = @game.photos.first.photo_file_name
    @photo_id = @game.photos.first.id
    attachments["#{@photo}"] = File.read(Rails.root.join("public/system/photos/#{@photo_id}/thumb/#{@photo}"))
    mail :to => receiver_email, :subject => "Interesting Game"
  end
  
  def comment_added(comment)
    @game = comment.game
    mail :to => @game.user.email, :subject => "New comment for '#{@game.title}'"
  end
  
  def game_added(game, user)
    @game = game
    @photo = @game.photos.first.photo_file_name
    @photo_id = @game.photos.first.id
    attachments["#{@photo}"] = File.read(Rails.root.join("public/system/photos/#{@photo_id}/thumb/#{@photo}"))
    mail :to => user.email, :subject => "Dear '#{user.email}'. New game was added '#{@game.title}'"
  end
end
