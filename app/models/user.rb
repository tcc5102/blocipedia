class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  # before_action :authenticate_user!
  before_save { self.role ||= :standard }
  # has_many :wikis, through: :collaborators, dependent: :destroy
  has_many :collaborators

  enum role: [:standard, :premium, :admin]

  def downgrade(user)
    user.standard!
  end

  def wikis
    Wiki.eager_load(:collaborators).where("wikis.private = ? OR wikis.user_id = ? OR collaborators.user_id = ?", false, id, id)
  end
end
