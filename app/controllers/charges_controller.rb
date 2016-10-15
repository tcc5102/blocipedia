class ChargesController < ApplicationController
  # before_action :upgrade_premium

  def create
    # Creates a Stripe Customer object, for associating
    # with the charge
    customer = Stripe::Customer.create(
      email: current_user.email,
      card: params[:stripeToken]
    )

    # Where the real magic happens
    charge = Stripe::Charge.create(
      customer: customer.id, # Note -- this is NOT the user_id in your app
      amount: 15_00,
      description: "Premium Membership",
      currency: 'usd'
    )

    flash[:notice] = "You are now a premium member!"
    current_user.premium!
    redirect_to edit_user_registration_path

    # Stripe will send back CardErrors, with friendly messages
    # when something goes wrong.
    # This `rescue block` catches and displays those errors.
    rescue Stripe::CardError => e
      flash[:alert] = e.message
      redirect_to new_charge_path
  end

  def new
    @stripe_btn_data = {
      key: "#{ Rails.configuration.stripe[:publishable_key] }",
      description: "Premium Membership",
      amount: 15_00
    }
  end

  # private
  #
  # def upgrade_premium
  #   current_user.role ||= :premium
  # end
end
