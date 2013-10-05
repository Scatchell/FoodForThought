Given(/^the item "([^"]*)" exists with a price of (\d+)/) do |name, price|
  item = Item.create!(name: name, price: price, created_at: Time.now, updated_at: Time.now, available: true, item_type: 'meat')

  item.save
end

When(/^the user is on the create an order page$/) do
  visit '/'
end

When(/^the user inputs a valid name$/) do
  fill_in('Name', :with => 'Test')
end

When(/^selects the "([^"]*)" item$/) do |item|
  check('I want')
end

When(/^creates the order$/) do
  click_button('Create Order')
end

Then(/^they should see a confirmation page showing the "([^"]*)" item$/) do |item|
  page.should have_content 'Order created for Test'
  page.should have_content 'Beef'
  page.should have_content 'Total price for this order: 5,000'
end