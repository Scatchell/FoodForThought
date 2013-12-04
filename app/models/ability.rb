class Ability
  include CanCan::Ability

  def initialize(user)
  	@user =  user
  	
  	if user.is_admin?
    	can [:destroy_all, :destroy, :index, :create, :show], Order
    else
    	can [:destroy, :create, :show], Order
    end

  
  end




end