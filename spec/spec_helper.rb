# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'
require 'rspec/autorun'
require 'capybara/rspec'

Dir[Rails.root.join("spec/support/**/*.rb")].each { |f| require f }
ActiveRecord::Migration.check_pending! if defined?(ActiveRecord::Migration)
RSpec.configure do |config|

  config.fixture_path = "#{::Rails.root}/spec/fixtures"
  config.use_transactional_fixtures = true
  config.infer_base_class_for_anonymous_controllers = false
  config.order = "random"
  
  def create_a_user(name = "testing_username")
    user = User.create!(password: "biscuits", username: name)
    visit new_session_url
    fill_in "username", :with => user.username
    fill_in "password", :with =>  user.password
    click_on "Login"
  end
  
  def build_user(name = "testing_username")
    User.create!(password: "biscuits", username: name )
  end
  
  def build_goal(user_id, title, public = false, completed = false)
    Goal.create!(
      public: public, 
      completed: completed, 
      user_id: user_id, 
      title: title
      )
  end
  
  def create_goal
    user = User.last
    visit new_user_goal_url(user)
    fill_in "Title", :with => "titties"
    check("Public")
    click_button "Create Goal"
  end
  
end
