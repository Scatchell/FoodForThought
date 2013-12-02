class Ability
  include CanCan::Ability

  def initialize(user)
  	user = current_user
  end
end