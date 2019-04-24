require 'rails_helper'

RSpec.describe GoalsController, type: :controller do
	let(:kevin) {
		User.create!(username: 'kevin', password: 'password')
	}
	before(:each) do
		allow_message_expectations_on_nil
	end
	

	describe "GET #new" do
		context "when logged in" do
			before do
				allow(controller).to receive(:current_user) { kevin }
			end

			it "renders the new goals page" do
				get :new
				expect(response).to render_template("new")
			end
		end

		context "when logged out" do
			before do
				allow(controller).to receive(:current_user) { nil }
			end

			it "redirects to log in page" do
				get :new
				expect(response).to redirect_to(new_user_url)
			end
		end
    end

	describe "POST #create" do
		context "when logged out" do
			before do
				allow(controller).to receive(:current_user) { nil }
			end

			it "redirects to log in page" do
				post :create, params: { goal: {} }
				expect(response).to redirect_to(new_user_url)
			end
		end

		context "when logged in" do
			before do
				allow(controller).to receive(:current_user) { kevin }
			end

			context "with invalid params" do
				it "validates the presence of title, is_private, and is_completed" do
					post :create, params: { goal: { goal_description: 'goal without title, is_private, or is_completed' } }
					expect(response).to render_template("new")
					expect(flash[:errors]).to be_present
				end
			end

			context "with valid params" do
				it "redirects user to goals page" do
					post :create, params: { goal: { goal_title: 'title', is_private: false, is_completed: false} }
					expect(response).to redirect_to(goal_url(Goal.last))
				end
			end
		end
    end
end
