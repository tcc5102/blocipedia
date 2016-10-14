# Store the environment variables on the Rails.configuration object
 Rails.configuration.stripe = {
   publishable_key: ENV['stripe_publishable_key'],
   secret_key: ENV['stripe_secret_key']
 }

 # Set our app-stored secret key with Stripe
 Stripe.api_key = Rails.configuration.stripe[:secret_key]
