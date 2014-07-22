class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable, :recoverable,
  devise :database_authenticatable, :registerable,
         :rememberable, :trackable, :validatable

         validates :name, presence: true
         validates :surname, presence: true
         validates :defaultWorkTime_id, presence: true
         validates :admin, presence: true
end
