# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'csv'

User.create([
  { username: 'SammyN', email: 'sammyn@pickanother.one', password: 'password' },
  { username: 'SammyJ', email: 'sammyj@pickanother.one', password: 'password' },
  { username: 'benbruno', email: 'jer@pickanother.one', password: 'password' },
  { username: 'Jer', email: 'benbruno@pickanother.one', password: 'password' },
  { username: 'Scott', email: 'scott@pickanother.one', password: 'password' }
])

# add tunes to db
csv_tunes = File.read("#{Rails.root}/db/csv/seedtunes.csv")
tunes = CSV.parse(csv_tunes, headers: true)
tunes.each do |row|
  tune = Tune.where(row.to_hash.slice('name', 'key')).first_or_create
  genre = Genre.find_by(name: row['genre'])
  next if (tune.genres.include?(genre)) || (tune.nil?) || (genre.nil?)

  tune.genres << genre
end

# add tunes to users
usernames = User.all.map(&:username)
csv_tunes_users = File.read("#{Rails.root}/db/csv/tunes_users.csv")
tunes_users = CSV.parse(csv_tunes_users, headers: true)
tunes_users.each do |row|
  tune = Tune.find_by(name: row['name'])
  next if tune.nil?

  usernames.each do |un|
    user = User.find_by username: un
    if (row[un] == 'y') && user.tunes.exclude?(tune)
      user.tunes << tune
    end
  end
end
