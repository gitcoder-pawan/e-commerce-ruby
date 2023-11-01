# spec/controllers/accounts_controller_spec.rb

require 'rails_helper'

describe AccountsController, type: :controller do
  before(:all) do 
    @account = FactoryBot.create(:acount)
  end

  describe "POST#signup" do 
    let(:valid_params){
        {data:{
            email: "abcgmail.com",
            password: "Paasword#2000",
            first_name: "Pawan",
            last_name: "kumar"
        }}
    }
    it 'creates account with valid params' do
        byebug
        post '/accounts/signup', valid_params
        expect(response).to have_http_status(:created)
    end

  end
end
