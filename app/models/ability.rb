class Ability
  include CanCan::Ability

  def initialize(user)
  	@user =  user
  	
  	if user.is_admin?
      can [:destroy_all, :destroy, :index, :create, :show], Order
      can [:mark_availability, :destroy, :index, :create, :show], Item
    else
    	can [:destroy, :create, :show], Order
    end

  
  end




end