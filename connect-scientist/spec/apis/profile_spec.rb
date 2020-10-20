require 'rails_helper'

describe "get index profile route", :type => :request do
  let!(:profile) {create(:profile, name: "june", user: build(:user))}
  let!(:profile2) {create(:profile, name: "june2", user: build(:user))}

  before {get '/api/v1/profiles'}

  it 'returns correct number of profiles' do
    expect(JSON.parse(response.body).size).to eq(2)
  end

  it 'returns correct serialized values' do
    expect(JSON.parse(response.body)[0].keys).to eq(["id", "name", "short_website_url", "num_friends"])
  end

  it 'returns correct name' do
    expect(JSON.parse(response.body)[0]["name"]).to eq("june")
  end

  it 'returns status code 200' do
    expect(response).to have_http_status(:success)
  end
end


describe "get show profile route", :type => :request do
  let!(:profile) {create(:profile, name: "june", user: build(:user))}
  before {get "/api/v1/profiles/#{profile.id}"}

  it 'returns correct serialized values' do
    expect(JSON.parse(response.body).keys).to eq(["id", "name", "long_website_url", "short_website_url", "payload", "friends"])
  end

  it 'returns correct name' do
    expect(JSON.parse(response.body)["name"]).to eq("june")
  end

  it 'returns status code 200' do
    expect(response).to have_http_status(:success)
  end
end

describe "find experts through friends", :type => :request do
  let!(:profile) {create(:profile, name: "june", user: build(:user))}
  let!(:profile2) {create(:profile, name: "july", long_website_url: "https://www.google.com/", user: build(:user))}
  let!(:profile3) {create(:profile, name: "august", long_website_url: "https://www.w3schools.com/html/html_headings.asp", 
                          user: build(:user))}

  before do
    # Add friendship
    profile.friendship_profiles << profile2
    profile2.friendship_profiles << profile3

    # Hit the endpoint
    post "/api/v1/profiles/#{profile.id}/find_expert",
      params: { keywords: 'Heading' }
  end

  it 'returns correct number of profiles' do
    expect(JSON.parse(response.body).size).to eq(1)
  end


  it 'returns correct serialized values' do
    expect(JSON.parse(response.body)[0].keys).to eq(["id", "name", "short_website_url", "payload", "path"])
  end

  it 'returns correct name' do
    expect(JSON.parse(response.body)[0]["name"]).to eq("august")
  end

  it 'returns status code 200' do
    expect(response).to have_http_status(:success)
  end
end
