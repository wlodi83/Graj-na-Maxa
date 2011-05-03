# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)
user = User.create [{
:email => 'lukasz.wlodarczyk@yahoo.com', 
:password => 'deftones',
:password_confirmation => 'deftones',
:admin => true
}]
Category.create [{:name => 'Action'},
{:name => 'Sports'},
{:name => 'Puzzle'},
{:name => 'Shooting'},
{:name => 'Arcade'},
{:name => 'Strategy'},
{:name => 'Adventure'},
{:name => 'Life & Style'}]
AgeBracket.create [
{ :name => 'All Ages', :description => "Games rated \"All Ages\" contain content and themes that are suitable for all ages." },
{ :name => 'Tween+', :description => "Games rated \"Tween +\" contain content and mild suggestive themes that are suitable for ages 10 and older. Some users also might find these games too difficult to play." },
{ :name => 'Teen+', :description => "Games rated \"Teen +\" contain suggestive themes that are suitable for ages 13 and older." },
{ :name => 'Teen Caution', :description => "Games rated \"Teen Caution\"  contain content and stronger suggestive themes that may or may not be suitable for ages 13 and older." }]
