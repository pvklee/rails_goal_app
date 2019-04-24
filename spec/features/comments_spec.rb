# spec/features/auth_spec.rb

require 'rails_helper'
require 'support/auth_features_helper.rb'
include AuthFeaturesHelper

feature 'commenting' do
	given!(:hello_world) { FactoryBot.create(:user_hw)}
	given!(:foo_bar) {FactoryBot.create(:user_foo)}
	given!(:foo_goal) do
		FactoryBot.create(:goal, user: foo_bar)
	end

	background(:each) do
		login_as(hello_world)
		visit user_url(foo_bar)
	end

	shared_examples 'comment' do
		scenario 'should have a form for adding a new comment' do
			expect(page).to have_content 'New Comment'
			expect(page).to have_field 'Comment'
		end

		scenario 'should save the comment when a user submits one' do
			fill_in 'Comment', with: 'my magical comment!'
			click_on 'Submit Comment'
			expect(page).to have_content 'my magical comment!'
		end
	end

	feature 'user profile comment' do
		it_behaves_like 'comment'
	end

	feature 'goal comment' do
		background(:each) do
			click_on foo_goal.goal_title
		end

		it_behaves_like 'comment'
	end

end
