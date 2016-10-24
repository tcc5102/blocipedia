class UsersController < ApplicationController
  def downgrade
    @user = current_user
    @user.downgrade(current_user)
    if @user.save
      flash[:notice] = "Premium membership cancelled successfully."
      redirect_to edit_user_registration_path
    else
      flash.now[:alert] = "There was an error cancelling your premium membership."
      redirect_to edit_user_registration_path
    end

    @wikis = Wiki.where(private: true, user_id: @user.id)
    @wikis.each do |wiki|
      wiki.private = false
      wiki.save!
    end
  end
end
