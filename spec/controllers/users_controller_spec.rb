require 'rails_helper'
require 'spec_helper'

RSpec.describe UsersController, type: :controller do
  
  subject(:user) { User.create(username: 'username', password: 'password')}
  
  describe "GET #new" do
    it "renders the new template" do 
      get :new, {}
      expect(response).to render_template("new")
    end
  end
  
  describe "POST #create" do 
    context "with invalid params" do 
      it "validates the presence of a username and password" do 
        post :create, params: {user: {username: "", password: "password"} }
        expect(response).to redirect_to(new_user_url)
        expect(flash[:errors]).to be_present
      end 
      
      it "validates the length of the password" do 
        post :create, params: {user: {username: "username", password: "pas"} }
        expect(response).to redirect_to(new_user_url)
        expect(flash[:errors]).to be_present
      end
    end
    
    context "with valid params" do 
      it "redirects user to sign in page on success" do 
        post :create, params: {user: {username: "names", password: "password"} }
        expect(response).to redirect_to(user_url(User.find_by(username: "names")))
      end
    end 
  end
  
  describe "GET #show" do 
    it "opens the show page of a user" do 
      get :show, params: {id: user.id}
      expect(response).to render_template("show")
    end
  end
  
  describe "GET #edit" do 
    it "renders the edit template" do 
      get :edit, params: {id: user.id}
      expect(response).to render_template("edit")
    end
  end
  
  describe "PATCH #update" do 
    context "with valid params" do 
      it "updates the user and redirects to user page" do 
        patch :update, params: { user: {id: user.id} }
        expect(response).to redirect_to user_url(user)
      end
    end
    
    context "with invalid params" do 
      it "redirects to edit page with flash errors" do 
        patch :update, params: { user: {id: user.id} }
        expect(response).to redirect_to edit_user_url(user)
        expect(flash[:errors]).to be_present
      end
    end
  end
  
  describe "DELETE #destroy" do 
    it "deletes the user" do 
      delete :destroy, params: { id: user.id }
      expect(response).to redirect_to users_url
    end
  end
end
