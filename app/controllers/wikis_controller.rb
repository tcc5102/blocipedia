class WikisController < ApplicationController
  include ApplicationHelper
  include CollaboratorsHelper

  before_action :require_sign_in, except: [:index, :show]
  before_action :authorize_user, except: [:create, :new, :index, :show]

  def index
    @public_wikis = current_user.wikis.where(private: false)
    @private_wikis = current_user.wikis.where(private: true)
  end

  def show
    @wiki = Wiki.find(params[:id])
  end

  def new
    @wiki = Wiki.new
  end

  def create
    @user = current_user
    @wiki = Wiki.new(params.require(:wiki).permit(:title, :body, :private))
    @wiki.user_id = @user.id

    if @wiki.save
      flash[:notice] = "wiki was saved."
      redirect_to @wiki
    else
      flash.now[:alert] = "There was an error saving the wiki. Please try again."
      render :new
    end
  end

  def edit
    @wiki = Wiki.find(params[:id])
  end

  def update
    @wiki = Wiki.find(params[:id])
    @wiki.assign_attributes(wiki_params)

    if @wiki.update_attributes(params.require(:wiki).permit(:title, :body, :private))
      flash[:notice] = "wiki was updated."
      redirect_to @wiki
    else
      flash.now[:alert] = "There was an error saving the wiki. Please try again."
      render :edit
    end
  end

  def destroy
    @wiki = Wiki.find(params[:id])

    if @wiki.destroy
      flash[:notice] = "\"#{@wiki.title}\" was deleted successfully."
      redirect_to wikis_path
    else
      flash.now[:alert] = "There was an error deleting the wiki."
      render :show
    end
  end

  private

  def wiki_params
    params.require(:wiki).permit(:title, :body, :private)
  end

  def authorize_user
    @wiki = Wiki.find(params[:id])
    unless current_user == @wiki.user || current_user.admin? || current_collaborators(current_user)
      flash[:alert] = "You must be the creator of the wiki to do that."
      redirect_to @wiki
    end
  end
end
