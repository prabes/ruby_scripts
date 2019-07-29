require 'pg'

begin 
  con =PG.connect :dbname => 'favdb', :user => 'rdeyvil'
  puts con.server_version

  #con.exec "DROP TABLE IF NOT EXISTS favlist"
  con.exec "CREATE TABLE IF NOT EXISTS favlist(id SERIAL PRIMARY KEY, username VARCHAR(20), fav_food VARCHAR(20), fav_place VARCHAR(20) )"

  details = con.exec "SELECT * FROM favlist"
  
  details.each do |detail|
    puts "|%s| |%s| |%s| |%s|" [ detail[id], detail[username], detail[fav_food], detail[fav_place]]
  end
  
  puts"Enter UserName:"
  username = gets.chomp.to_str

  puts"Enter Favorite Food:"
  fav_food = gets.chomp.to_str

  puts"Enter Favorite Place:"
  fav_place = gets.chomp.to_str
  
  con.exec "INSERT INTO favlist (username, fav_food, fav_place) VALUES ('#{username}','#{fav_food}','#{fav_place}')"
rescue PG::Error => e 
  puts e.message

ensure

  details.clear if details
  con.close if con
   
end




puts"Hello #{username}! \nVisit #{fav_place} and I'll give you #{fav_food}."