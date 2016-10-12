class WikisController < ApplicationController
  before_action :require_sign_in, except: [:index, :show]
  # before_action :authorize_user, except: [:index, :show]

  def index
    @wikis = Wiki.all
  end

  def show
    @wiki = Wiki.find(params[:id])
  end

  def new
    @wiki = Wiki.new
  end

  def create
    @wiki = Wiki.create(wiki_params)
    @wiki.user = current_user

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

    if @wiki.save
      flash[:notice] = "wiki was updated."
      redirect_to @wiki
    else
      flash.now[:alert] = "There was an error saving the wiki. Please try again."
      render :edit
    end
  end

  # def publish
  #   @wiki = Wiki.find(params[:id])
  #   authorize @wiki, :update?
  #   @wiki.publish!
  #   redirect_to @wiki
  # end

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

  def authorize_user
    unless current_user
      flash[:alert] = "You must be a user to do that."
      redirect_to wikis_path
    end
  end

  private

  def wiki_params
    params.require(:wiki).permit(:title, :body)
  end

  def authorize_user
    wiki = Wiki.find(params[:id])
    unless current_user == wiki.user || current_user.admin?
      flash[:alert] = "You must be the creator of the wiki to do that."
      redirect_to [wiki]
    end
  end
end
