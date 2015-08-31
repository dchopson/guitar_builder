class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :orders

  def self.all_for_select
    all.map{|u| [u.name, u.id]}
  end

  def name
    "#{first_name} #{last_name}"
  end
end
