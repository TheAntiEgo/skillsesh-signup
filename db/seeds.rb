#
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

15.times {
  User.create(:provider => "facebook",
              :provider_uid => SecureRandom.hex(6),
              :provider_token => SecureRandom.uuid,
              :provider_token_expires_at => 3.days.from_now,
              :remember_token => SecureRandom.uuid,
              :first_name => Faker::Name.first_name,
              :last_name => Faker::Name.last_name,
              :email => Faker::Internet.email,
              :bio => Faker::Lorem.sentences(3).join,
              :photo => URI.parse( "http://api.randomuser.me/portraits/" + %w{ men women}.shuffle.first + '/' + (0...95).last(94).shuffle.first.to_s + '.jpg'),
              :learnables => Faker::Lorem.words(3).join,
              :teachables => Faker::Lorem.words(3).join
              )
}
