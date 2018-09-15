require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  #new
  #create
  #show
  
  describe "GET #new" do
    it "renders new users template" do
      get :new
      
      expect(response).to render_template(:new)
    end   
  end
  
  describe "POST #create" do
    context "with valid params" do 
      it "logs user in" do 
        post :create, params: {user: {username: 'Jerry', password: 'cookiedough'}}
        user = User.find_by(username: 'Jerry')
        
        expect(session[:session_token]).to eq(user.session_token)
      end
         
      it "renders user page" do
        post :create, params: {user: {username: 'Jerry', password: 'cookiedough'}}
        user = User.find_by(username: 'Jerry')
        
        expect(response).to redirect_to(user_url(user))
      end
    end
    
    context "with invalid params" do
      it "rerenders new users template with errors" do 
        post :create, params: {user: {username: '', password: 'ugh'}}
        
        expect(response).to render_template(:new)
        expect(flash.now[:errors]).to be_present
      end
    end
    
    describe "GET #show" do
      it "renders user's template" do
        User.create(username: "Cookie", password: "doughhhhh")
        user = User.find_by(username: "Cookie")
        get :show, params: {id: user.id}
        
        expect(response).to render_template(:show)
      end
    end
  end
  
  
end
