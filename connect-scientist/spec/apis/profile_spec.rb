require 'rails_helper'

describe "get all profile route", :type => :request do
  let!(:profile) {create(:profile, name: "june", user: build(:user))}
  before {get '/api/v1/profiles'}

  it 'returns correct number of profiles' do
    expect(JSON.parse(response.body).size).to eq(1)
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


describe "get one profile route", :type => :request do
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
