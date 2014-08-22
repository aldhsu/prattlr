require 'rails_helper'

RSpec.describe UsersController, :type => :controller do

  describe "POST create" do
    describe "VALID DATA" do
      before do
        post :create, user: {
          username: 'test',
          password: 'test',
          password_confirmation: 'test'
        }
      end

      it 'automaticaly log the user in' do
        expect(session[:user_id]).to eq(User.first.id)
      end

      it 'redirects to root_path' do
        expect(response.status).to eq(302)
        expect(response).to redirect_to( root_path )
      end
    end

    describe "INVALID DATA" do
      before do
        post :create, user: {username: ""}
      end
      it 'should render new' do
        expect(response).to render_template(:new)
      end
    end
  end

  describe "GET new" do
    it "returns http success" do
      get :new
      expect(response).to be_success
    end
  end

end
