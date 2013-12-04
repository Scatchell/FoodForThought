require 'spec_helper'

describe User do
	describe 'role' do
		it 'should be default to false' do
			user = User.new
			user.is_admin.should == false
		end
	end
end
