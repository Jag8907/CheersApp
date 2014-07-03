require 'spec_helper'

feature "goal creation process" do
  before { create_a_user }
  
  it "has a new goal page" do
    user = User.last
    visit new_user_goal_url(user)
    save_and_open_page
    expect(page).to have_content "Create goal" 
    expect(current_url).to eq new_user_goal_url(user)
  end
 


end