require 'rails_helper'

RSpec.describe UsersController, type: :controller do
    describe "GET #new" do
        it "renders the new template" do
            get :new, {}
            expect(response).to render_template("new")
        end
    end

    describe "POST #create" do
        context "with invalid params" do
            it "validates the presence of username and password" do
                get :create, params: { user: { username: 'username', password: '' } }
                expect(response).to render_template("new")
            end

            it "validates that the password is at least 6 characters long" do
                get :create, params: { user: { username: 'username', password: 'short' } }
                expect(response).to render_template("new")
            end
        end

        context "with valid params" do
            it "redirects user to goals page" do
                get :create, params: { user: { username: 'username', password: 'password' } }
                expect(response).to redirect_to(goals_path)
            end
        end
    end

end
