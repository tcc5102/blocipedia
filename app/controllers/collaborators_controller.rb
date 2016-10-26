class CollaboratorsController < ApplicationController
  before_action :require_sign_in

  def create
    @wiki = Wiki.find(params[:wiki_id])
    @collaborator = Collaborator.new
    @collaborator.user_id = params[:collaborator][:user_id]
    @collaborator.wiki = @wiki

    if @collaborator.save
      flash[:notice] = "Added collaborator #{@collaborator.user_id}"
    else
      flash[:alert] = "Failed to add collaborator #{@collaborator.user_id}"
    end
    redirect_to :back
  end

  def destroy
    @wiki = Wiki.find(params[:wiki_id])
    @collaborator = Collaborator.find(params[:id])

    if @collaborator.destroy
      flash[:notice] = "Removed collaborator"
    else
      flash[:alert] = "Failed to remove collaborator"
    end
    redirect_to :back
  end
end
