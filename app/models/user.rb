class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :orders

  def self.all_for_select
    all.map{|u| [u.name, u.id]}
  end

  # Override Devise to not admit a user was not found
  # See http://guides.rubyonrails.org/security.html#brute-forcing-accounts
  def self.send_reset_password_instructions(attributes={})
    recoverable = super
    recoverable.errors.clear
    recoverable
  end

  def name
    "#{first_name} #{last_name}"
  end
end
