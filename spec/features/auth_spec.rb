require 'spec_helper'

feature "the signup process" do 

  it "has a new user page" do
    visit new_user_url
    expect(page).to have_content "Sign Up"
  end

  feature "signing up a user" do
    before(:each) do
      visit new_user_url
      fill_in 'username', :with => 'testing_username'
      fill_in 'password', :with => 'biscuits'
      click_on "Create User"
    end

    it "shows username on the homepage after signup" do
      
  end

end

feature "logging in" do 

  it "shows username on the homepage after login"

end

feature "logging out" do 

  it "begins with logged out state"

  it "doesn't show username on the homepage after logout"

end
