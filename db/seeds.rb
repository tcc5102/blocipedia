require 'random_data'
# Create Wikis
10.times do
  Wiki.create!(
    user_id:   1,
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

# Create admin user
admin = User.create!(
  name:     'Admin User',
  email:    'admin@example.com',
  password: 'helloworld',
  role:     'admin'
)

# Create a standard user
standard = User.create!(
  name:     'Standard User',
  email:    'standard@example.com',
  password: 'helloworld'
)

# Create a premium user
premium = User.create!(
  name:     'Premium User',
  email:    'premium@example.com',
  password: 'helloworld'
)



puts "Seed Finished"
puts "#{Wiki.count} wikis created"
puts "#{User.count} users created"
