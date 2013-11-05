class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :username, presence: true
  validates :username, uniqueness: true, if: -> { self.username.present? }

  has_many :orders

  def self.notification_emails
    users = self.all.select {|user| user.notifications }

    users.collect(&:email)
  end
end
