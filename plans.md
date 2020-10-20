# README

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

### Models
  - User
    - Created using devise
    - Used to sign up and sign in
    - Has one to one relationship with profile
  
  - Profile
    - Attributes
      - name
      - personal website url
      - shorten website url
      - heading values could be json or another tables
    - Has 1:m with friendship
    - There should be two concerns
      - Create shorten url if url is correct (validate long url)
      - Grab heading after creating the profile (JSON attributes)

  - Friendship
    - attributes
      - frinedid
      - user_id 
    - belong to profile
    - there should be call back for creating bi directional
      relationship

### APIs
  - GET
    - PROFILE
      - When grabbing all users, serializer should be 
        - name,
        - short url
        - number of friends

      - For indivisual users,
        - name
        - website URL
        - shortening
        - website headings
        - links to their friends' pages with friend name

  - POST
    - SIGN UP (inherit from devise)
      - body
        - email
        - password

    _ SIGN IN (inherit from devise)
        - email
        - password
    - For searching not friends who is in expert of certain topic.
      - { topic: [ ] }
    - returns { friends } with just links?
    - User regex.
  
  
### Frontend
  - Use bootstrap for quick development
  - Simple Sign up and sign in pages 
  - index all users (paginate them)
  - show indivisual users and their friends 
    - search bar to search non friend' topic

## Gems
```
  # Parsing gem
  gem 'nokogiri' 
  gem 'open-uri'
  gem 'devise'
  # Serializer
  gem 'active_model_serializers'
  group :development do
    ...
    gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
    gem 'rspec-rails', '~> 3.5'
    gem 'annotate'
    ...
  end
  group :test do
    ...
    # For creating realistic test data, and tests
    gem 'factory_bot_rails', '~> 4.0'
    gem 'shoulda-matchers', '~> 3.1'
    gem 'faker'
    gem 'database_cleaner'
    ...
  end
```

### Dockerize
 - Dockerize everything so it is easy to run.

This README would normally document whatever steps are necessary to get the
application up and running.
