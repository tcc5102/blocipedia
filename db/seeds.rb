require 'random_data'
# Create Wikis
 10.times do
   Wiki.create!(
     title:  RandomData.random_sentence,
     body:   RandomData.random_paragraph
   )
 end
 wikis = Wiki.all

# Create Users
5.times do
  User.create!(
    email:    RandomData.random_email,
    password: RandomData.random_sentence
  )
end



puts "Seed Finished"
puts "#{Wiki.count} wikis created"
puts "#{User.count} users created"
