class UserController < ApplicationController
  def emails
    @emails = User.notification_emails
  end
end
