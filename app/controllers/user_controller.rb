class UserController < ApplicationController
  def emails
    @emails = User.all.collect(&:email)
  end
end
