require "cancan/matchers"
require 'spec_helper'

describe 'User' do 
	describe "abilities" do		 
		context "when is an admin" do
			let(:user) {stub_model User, :is_admin => true}		
			subject(:ability){ Ability.new(user) }
			
			it{ should be_able_to(:destroy_all, Order.new) }
			it{ should be_able_to(:destroy, Order.new) }
			it{ should be_able_to(:index, Order.new) }
			it{ should be_able_to(:create, Order.new) }
			it{ should be_able_to(:show, Order.new) }

		end

		context "when is a user" do
			let(:user) {stub_model User, :is_admin => false}		
			subject(:ability){ Ability.new(user) }
			
			it{ should be_able_to(:destroy, Order.new) }
			it{ should be_able_to(:create, Order.new) }
			it{ should be_able_to(:show, Order.new) }
		end

	end
end