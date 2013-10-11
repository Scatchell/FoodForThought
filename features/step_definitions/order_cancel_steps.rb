include Devise::TestHelpers

And(/^I cancel the order$/) do
  click_button 'Remove this order and try again'
  #page.driver.accept_js_confirms!
  page.driver.browser.switch_to.alert.accept
end

Then(/^I should see the new order page$/) do
  page.should have_content 'Create Your Order'
end

When(/^the order should not exist$/) do
  Order.where(user: @valid_user).should be_empty
end