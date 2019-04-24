# spec/features/auth_spec.rb

require 'spec_helper'
require 'rails_helper'

feature 'the signup process' do
	scenario 'has a new user page' do
		visit new_user_url
		expect(page).to have_content "New user"
  end

  feature 'signing up a user' do
		before(:each) do
			visit new_user_url
			fill_in 'user_username', :with => 'username'
			fill_in 'user_password', :with => 'password'
			click_on "Create User"
		end

		scenario 'shows username on the homepage after signup' do
			expect(page).to have_content "username"
		end

  end
end

feature 'logging in' do
	before(:each) do
		visit new_session_url
		fill_in 'user_username', :with => 'username'
		fill_in 'user_password', :with => 'password'
		click_on "user_log_in"
	end

	scenario 'shows username on the homepage after login' do
		expect(page).to have_content "username"
	end

end

feature 'logging out' do
	scenario 'begins with a logged out state' do
	end

	scenario 'doesn\'t show username on the homepage after logout' do
	end

end