include Devise::TestHelpers

Given(/^the following items exist:$/) do |table|
  table.hashes.each do |i|
    item = Item.new(i)
    item.item_type='meat'
    item.available=true
    item.save!
    #Item.new(name: item['name'], price: item['price'], created_at: Time.now, updated_at: Time.now, available: true, item_type: 'meat')
  end
end

And (/^a valid user exists$/) do
  @username = 'Anthony'
  @email = 'ascatche@thoughtworks.com'
  @password = 'password'
  @valid_user = User.new(username: @username, email: @email, password: @password, password_confirmation: @password)
  @valid_user.save!
end

And(/^I sign in$/) do
  visit '/users/sign_in'
  fill_in "user_email", :with => @email
  fill_in "user_password", :with => @password
  click_button "Sign in"
end

And(/^I go to the order creation page$/) do
  visit '/'
end

And(/^I select two items on the menu$/) do
  find(:css, "#items_[value='1']").set(true)
  find(:css, "#items_[value='2']").set(true)
end

And(/^I create the order$/) do
  click_button('Create Order')
end

Then(/^I should see a confirmation page showing the "(.*?)" item and my username$/) do |item_name|
  page.should have_content "Order created for #{@username}"
  page.should have_content item_name
  page.should have_content 'Total price for this order: 5,000'
end

Then(/^I should see the order I created$/) do
  page.should have_content 'Order created for Anthony'
  page.should have_content 'Rice'
  page.should have_content 'Beans'
end

And(/^the order should exist$/) do
  Order.where(user: @valid_user).size.should == 1
end
