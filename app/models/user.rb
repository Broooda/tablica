class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable, :recoverable,
  devise :database_authenticatable, :registerable,
         :rememberable, :trackable, :validatable

        validates :name, presence: true
        validates :surname, presence: true
      
        has_one :default_work_time
        has_one :default_work_time_request

        has_many :hours_plan
        has_many :holiday
end
