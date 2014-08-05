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

  scope :active,-> { where("accepted = true") }

  def full_name(badge=false)
    ret = "".html_safe
    ret << name+" "+surname
    ret << ' <span class="label label-danger">admin</span>'.html_safe if badge and self.admin
    ret
  end

  def get_tags
    full_name + " " + tags
  end

  def tags_array
    tags.split(" ")
  end

  def self.get_all_tags
    tags=[]
    User.all.each do |user|
      tags = tags | user.tags_array
    end
    tags
  end

end
