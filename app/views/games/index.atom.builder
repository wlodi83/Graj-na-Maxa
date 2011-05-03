atom_feed do |feed|
  feed.title("Awesome Games")
  feed.updated(@games.first.created_at)

  @games.each do |game|
    feed.entry(game) do |entry|
      entry.title(game.title)
      entry.content(game.description)
      
      entry.author do |author|
        author.name("The Awesome Games")
      end
    end
  end
end
