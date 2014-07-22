Given(/^I am on the homepage$/) do
  visit('/')
end

When(/^I start a new game$/) do
  click_link('New Game')
end

Then(/^I am asked for 2 player names$/) do
  page.has_css?('input[name=player1name]')
  page.has_css?('input[name=player2name]')
end

Then(/^I fill in (\d+) player names$/) do |arg1|
  fill_in('player1name', :with => 'Zoe')
  fill_in('player2name', :with => 'Joe')
end

Then(/^I press the "(.*?)" button$/) do |button_text|
  click_button(button_text)
end

Then(/^I should be brought to the welcome page$/) do
  page.has_content?('Registration Success!')
end

Given(/^I am on the registration page$/) do
  visit('/registration')
end

Then(/^I should not be brought to the welcome page$/) do
  pending # express the regexp above with the code you wish you had
end

