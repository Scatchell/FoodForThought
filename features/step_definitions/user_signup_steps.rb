Given(/^no user with username "(.*?)" exists:$/) do |username|
    User.where(:username => username).should be_empty
end

When(/^I go to the sign up page$/) do
    visit "/users/sign_up"
end

When(/^I fill in "(.*?)" for "(.*?)"$/) do |value,field|
    fill_in field , :with => value
end

When(/^I follow the "(.*?)" button$/) do |button|
    within(:css, "#new_user") do
      click_on button
    end
end
Then(/^I should see "(.*?)"$/) do |message|
    page.should have_content message
end
