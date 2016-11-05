class CollaboratorsController < ApplicationController
  before_action :require_sign_in

  def create
    @wiki = Wiki.find(params[:wiki_id])
    user = User.where(email: params[:email]).first


    if user.nil?
      flash[:notice] = "User does not exist"
    elsif Collaborator.where(user: user, wiki: @wiki).first
      flash[:notice] = "#{user.email} is already collaborating"
    else
      if Collaborator.create!(user: user, wiki: @wiki)
        flash[:notice] = "#{user.email} is now a collaborator"
      else
        flash[:error] = "Failed to add collaborator"
      end
    end
    redirect_to edit_wiki_path(@wiki)
  end

  def destroy
    wiki = Wiki.find(params[:wiki_id])
    @collaborator = Collaborator.find(params[:id])

    if @collaborator.destroy
      flash[:notice] = "Removed collaborator #{@collaborator.user.email}"
    else
      flash[:alert] = "Failed to remove collaborator"
    end
    redirect_to edit_wiki_path(wiki)
  end
end
