require "cancan/matchers"
require 'spec_helper'

describe 'User' do 
	describe "abilities" do		 
		context "when is an admin" do
			let(:user) {stub_model User, :is_admin => true}		
			subject(:ability){ Ability.new(user) }
			
			it{ should be_able_to(:destroy_all, Order) }
			it{ should be_able_to(:destroy, Order) }
			it{ should be_able_to(:index, Order) }
			it{ should be_able_to(:create, Order) }
			it{ should be_able_to(:show, Order) }

			it{ should be_able_to(:mark_availability, Item) }
			it{ should be_able_to(:destroy, Item) }
			it{ should be_able_to(:index, Item) }
			it{ should be_able_to(:create, Item) }
			it{ should be_able_to(:show, Item) }
		end

		context "when is a user" do
			let(:user) {stub_model User, :is_admin => false}		
			subject(:ability){ Ability.new(user) }
			
			it{ should be_able_to(:destroy, Order) }
			it{ should be_able_to(:create, Order) }
			it{ should be_able_to(:show, Order) }
			it{ should_not be_able_to(:index, Order)}
			it{ should_not be_able_to(:destroy_all, Order)}
		end
	end
end