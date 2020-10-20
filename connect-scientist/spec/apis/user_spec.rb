require 'rails_helper'

describe "User Login", :type => :request do
  let!(:profile) {create(:profile, name: "june", user: build(:user, email: "test@gmail.com", password: "password"))}

  before do 
    post "/api/v1/sessions/create",
      params: { user: { email: "test@gmail.com", password: "password" } }
  end

  it 'returns status code 200' do
    expect(response).to have_http_status(:success)
  end
end

describe "User Logout", :type => :request do
  let!(:profile) {create(:profile, name: "june", user: build(:user, email: "test@gmail.com", password: "password"))}

  before do 
    post "/api/v1/sessions/create",
      params: { user: { email: "test@gmail.com", password: "password" } }

    post "/api/v1/sessions/destroy"
  end

  it 'returns status code 200' do
    expect(response).to have_http_status(:success)
  end
end


describe "SingUp", :type => :request do
  before do 
    post "/api/v1/registrations/create",
      params: { 
       user: { email: "test@gmail.com", password: "password" }, 
       profile: { name: "june", long_website_url: "http://google.com/" }
      }
  end

  it 'returns status code 200' do
    expect(response).to have_http_status(:success)
  end
end
