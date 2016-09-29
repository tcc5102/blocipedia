class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  # before_action :authenticate_user!
  before_save { self.role ||= :standard }
  has_many :wikis, dependent: :destroy

  enum role: [:standard, :premium, :admin]
end
