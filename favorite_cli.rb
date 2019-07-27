require 'pg'

begin 
  con =PG.connect :dbname => 'favdb', :user => 'rdeyvil'
  puts con.server_version

  con.exec "DROP TABLE IF EXISTS favlist"
  con.exec "CREATE TABLE favlist(id INTEGER PRIMARY KEY, username VARCHAR(20), fav_food VARCHAR(20), fav_place VARCHAR(20) )"

  con.exec "INSERT INTO favlist "
  details = con.exec "SELECT * FROM favlist"
  details.each do |detail|
    puts "|%s| |%s| |%s|" [detail[id], detail[username], detail[fav_food], detail[fav_place]]
  end
rescue PG::Error => e 
  puts e.message

ensure

  con.close if con 
end

puts"Enter UserName:"
username = gets.chomp.to_str

puts"Enter Favorite Food:"
fav_food = gets.chomp.to_str

puts"Enter Favorite Place:"
fav_place = gets.chomp.to_str


puts"Hello #{username}! \nVisit #{fav_place} and I'll give you #{fav_food}."