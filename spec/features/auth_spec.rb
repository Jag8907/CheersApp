require 'spec_helper'
feature "the signup process" do 

  it "has a new user page" do
    visit new_user_url
    expect(page).to have_content "Sign Up"
  end
 
  feature "signing up a user" do
    let(:new_user) { 
      visit new_user_url
      fill_in "username", :with => 'testing_username'
      fill_in "password", :with =>  'biscuits'
    }
    
    before(:each) do
      new_user
    end

    it "shows username on the homepage after signup" do
      click_on "Create User"
      expect(page).to have_content "testing_username"
    end
    
    it "validates presence of username" do      
      visit new_user_url
      click_on "Create User"
      expect(page).to have_content "Username can't be blank"
    end
    
    it "validates presence of password" do
      visit new_user_url
      click_on "Create User"
      expect(page).to have_content "Password can't be blank"
    end
    
    it "redirects to users show page" do
      click_on "Create User"
      expect(current_url).to eq user_url(User.last.id)
    end
    
    it "checks password length is six or greater" do
      visit new_user_url
      fill_in 'username', :with => 'testing_username'
      fill_in 'password', :with => '12345'
      click_on "Create User"
      expect(page).to have_content "Password is too short"
    end
    
    it "doesn't create duplicate users" do
      User.create!(password: "biscuits", username: "testing_username")
      visit new_user_url
      fill_in 'username', :with => 'testing_username'
      fill_in 'password', :with => '123456'
      click_on "Create User"
      expect(page).to have_content "Username has already been taken"
    end
  end
end

feature "logging in" do 
  let(:user) { User.create!(password: "biscuits", username: "testing_username")}
  
  let(:login) { 
    visit new_session_url
    fill_in "username", :with => user.username
    fill_in "password", :with =>  user.password
    click_on "Login"
  }
    
  it "validates presence of username" do      
    visit new_session_url
    fill_in 'password', :with => 'biscuits'
    click_on "Login"
    expect(page).to have_content "Invalid username or password"
  end
  
  it "validates presence of password" do      
    visit new_session_url
    fill_in 'username', :with => 'testing_username'
    click_on "Login"
    expect(page).to have_content "Invalid username or password"
  end

  it "shows username on the homepage after login" do 
    login
    expect(current_url).to eq user_url(User.last.id)
  end
  
  it "does not allow logged in user to log in" do      
    user
    login
    visit new_session_url
    expect(current_url).to_not eq new_session_url
  end
  
  it "does not allow logged in user to sign up" do      
    user
    login
    visit new_user_url
    expect(current_url).to_not eq new_user_url
  end
  
end

feature "logging out" do 
  let(:user) { User.create!(password: "biscuits", username: "testing_username")}
  
  let(:login) { 
    visit new_session_url
    fill_in "username", :with => user.username
    fill_in "password", :with =>  user.password
    click_on "Login"
  }
  
  it "begins with logged out state" do
    user
    visit user_url(User.last.id)
    expect(current_url).to eq new_session_url
  end

  it "doesn't show username on the homepage after logout" do
    user
    login
    click_on "Log Out"
    visit user_url(User.last.id)
    page.should have_content 'Sign In'
  end
end