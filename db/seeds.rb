require 'random_data'
# Create Users
10.times do
  User.create!(
    name:     Faker::Name.name,
    email:    Faker::Internet.email,
    password: Faker::Internet.password,
    role:     'standard'
  )
end
users = User.all

# Create Wikis
10.times do
  Wiki.create!(
    user:     users.sample,
    title:    Faker::Name.title,
    body:     Faker::Lorem.paragraph
  )
end
wikis = Wiki.all

# Create admin user
admin = User.new(
  name:     'Admin User',
  email:    'admin@example.com',
  password: 'helloworld',
  role:     'admin'
)
admin.skip_confirmation!
admin.save

# Create a standard user
standard = User.new(
  name:     'Standard User',
  email:    'standard@example.com',
  password: 'helloworld',
  role:     'standard'
)
standard.skip_confirmation!
standard.save

# Create a premium user
premium = User.new(
  name:     'Premium User',
  email:    'premium@example.com',
  password: 'helloworld',
  role:     'premium'
)
premium.skip_confirmation!
premium.save



puts "Seed Finished"
puts "#{Wiki.count} wikis created"
puts "#{User.count} users created"
