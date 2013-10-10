class SetAllExistingUsersToDefaultUser < ActiveRecord::Migration
  def up
    default_user = User.new(username: 'no_user_exists', email: 'no_user@user.com', password: 'password', password_confirmation: 'password')
    default_user.save!

    Order.all.each do |order|
      order.update_attributes(user: default_user)
    end

    OrderHistory.all.each do |order_history|
      order_history.update_attributes(user: default_user)
    end
  end

  def down
    default_user = User.where(username: 'no_user_exists', email: 'no_user@user.com').first

    Order.where(user: default_user).each do |order|
      order.user = nil
    end

    OrderHistory.where(user: default_user).each do |order|
      order.user = nil
    end

    default_user.destroy!
  end
end
