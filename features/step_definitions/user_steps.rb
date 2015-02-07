### UTILITY METHODS ###

def sign_up_with(user_attributes)
  visit new_user_registration_path
  fill_in 'user_email', with: user_attributes[:email]
  fill_in 'user_password', with: user_attributes[:password]
  fill_in 'user_password_confirmation', with: user_attributes[:password_confirmation]
  click_button 'Sign up'
end

def signin(email, password)
  visit new_user_session_path
  fill_in 'user_email', with: email
  fill_in 'user_password', with: password
  click_button 'Log in'
end

### GIVEN/WHEN/THEN ###

Given(/^I do not exist as a user$/) do
  @user = FactoryGirl.build(:user)
  @user ||= User.where(email: @visitor[:email]).first
  @user.destroy unless @user.nil?
end

When(/^I sign in with valid credentials$/) do
  signin(@user.email, @user.password)
end

Then(/^I see an invalid credentials message$/) do
  expect(page).to have_content I18n.t('devise.failure.not_found_in_database', authentication_keys: 'email')
end

Given(/^I exist as a user$/) do
  @user = FactoryGirl.create(:user)
end

Given(/^I am not signed in$/) do
  step "I sign out"
end

Then(/^I see a success message$/) do
  expect(page).to have_content I18n.t('devise.sessions.signed_in')
end

When(/^I sign in with a wrong email$/) do
  signin("wrongemail@example.com", @user.password)
end

Then(/^I see an invalid email message$/) do
  expect(page).to have_content I18n.t('errors.messages.invalid')
end

When(/^I sign in with a wrong password$/) do
  signin(@user.email, "wrongpassword")
end

Then(/^I see an invalid password message$/) do
  expect(page).to have_content I18n.t('devise.failure.invalid', authentication_keys: 'email')
end

Given(/^I am signed in$/) do
  steps %Q{
    Given I exist as a user
    When I sign in with valid credentials
  }
end

When(/^I sign out$/) do
  current_driver = Capybara.current_driver
  begin
    Capybara.current_driver = :rack_test
    page.driver.submit :delete, "/users/sign_out", {}
  ensure
    Capybara.current_driver = current_driver
  end
end

Then(/^I see a signed out message$/) do
  expect(page).to have_content I18n.t('devise.sessions.signed_out')
end

When(/^I sign up with valid data$/) do
  user = FactoryGirl.attributes_for(:user)
  user[:password_confirmation] = user[:password]
  sign_up_with(user)
end

Then(/^I see a successful sign up message$/) do
  txts = [I18n.t( 'devise.registrations.signed_up'), I18n.t( 'devise.registrations.signed_up_but_unconfirmed')]
  expect(page).to have_content(/.*#{txts[0]}.*|.*#{txts[1]}.*/)
end

When(/^I sign up with an invalid email address$/) do
  user = FactoryGirl.attributes_for(:user)
  user[:password_confirmation] = user[:password]
  user[:email] = 'bogus'
  sign_up_with(user)
end

When(/^I sign up without a password$/) do
  user = FactoryGirl.attributes_for(:user)
  user[:password_confirmation] = user[:password]
  user[:password] = ''
  sign_up_with(user)
end

Then(/^I see a missing password message$/) do
  expect(page).to have_content I18n.t('errors.messages.blank')
end

When(/^I sign up with a short password$/) do
  user = FactoryGirl.attributes_for(:user)
  user[:password_confirmation] = user[:password] = 'abc'
  sign_up_with(user)
end

Then(/^I see a 'too short password' message$/) do
  expect(page).to have_content I18n.t('errors.messages.too_short.other', count: 8)
end

When(/^I sign up without a password confirmation$/) do
  user = FactoryGirl.attributes_for(:user)
  user[:password_confirmation] = ''
  sign_up_with(user)
end

When(/^I sign up with a mismatched password confirmation$/) do
  user = FactoryGirl.attributes_for(:user)
  user[:password_confirmation] = user[:password] + 'abc'
  sign_up_with(user)
end

Then(/^I should see a mismatched password message$/) do
  expect(page).to have_content I18n.t('errors.messages.confirmation', attribute: 'Password')
end

Then(/^I see the login form$/) do
  expect(page).to have_content "Log in"
end

When(/^I sign up with valid data and an existing email$/) do
  user = FactoryGirl.attributes_for(:user, email: @other_user.email)
  user[:password_confirmation] = user[:password]
  sign_up_with(user)
end
