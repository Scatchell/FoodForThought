class UserController < ApplicationController
  http_basic_authenticate_with name: "allinall", password: "twcollins"

  def emails
    notification_emails = User.notification_emails

    notification_emails.each do |user_email|
      UserMailer.order_up_email(user_email).deliver
      puts "Order available mail sent to: #{user_email}"
    end

    flash[:notice] ||= []
    flash[:notice] << "Order mails sent successfully to #{notification_emails.size} users"

    redirect_to items_path
  end
end
