class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  attr_accessor :role

  validates :username, presence: true
  validates :username, uniqueness: true, if: -> { self.username.present? }

  has_many :orders

  def self.notification_emails
    users = users_to_notify

    users.collect(&:email)
  end

  def self.users_without_current_orders
    users_to_notify.select {|user| user.orders.empty?}
  end

  private
  def self.users_to_notify
    self.where(notifications: true)
  end
end
