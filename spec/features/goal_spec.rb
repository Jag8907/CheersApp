require 'spec_helper'

feature "goal creation process" do
  before { create_a_user }
  
  it "has a new goal page" do
    user = User.last
    visit new_user_goal_url(user)
    expect(current_url).to eq new_user_goal_url(user)
    expect(page).to have_content "Create Goal" 
  end
  
  it "redirect to goal page" do
    user = User.last
    visit new_user_goal_url(user)
    fill_in "Title", :with => "titties"
    click_button "Create Goal"
    expect(current_url).to eq goal_url(Goal.last)
    expect(page).to have_content "titties"
    expect(Goal.last.public).to be false
  end
  
  it "goal page has public true" do
    create_goal
    expect(Goal.last.public).to be true
  end
  
  it "goal has 'completed' button" do
    create_goal
    expect(page).to have_button "Completed" 
  end
end

feature "Privacy Settings" do
  
  before :each do
    create_a_user("user1")
    build_user("user2")
  end
  
  it "goal page is viewable by owner if private" do
    build_goal(User.first.id, "Test")
    visit goal_url(Goal.last)
    expect(Goal.last.public).to be false
    expect(current_url).to eq goal_url(Goal.last)
  end
  
  it "goal page is not viewable by other users if private" do
    build_goal(User.last.id, "Test")
    visit goal_url(Goal.last)
    expect(Goal.last.public).to be false
    expect(current_url).to_not eq goal_url(Goal.last)
  end
end