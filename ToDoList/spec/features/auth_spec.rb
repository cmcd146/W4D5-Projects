require 'spec_helper'
require 'rails_helper'

feature 'the sign up process' do
  # background :each do
  #   visit new_user_path
  # end
  
  scenario 'has a new user page' do
    visit new_user_path
    
    expect(page).to have_content('SIGN UP!!!')
  end
  
  scenario 'signing up a user' do  
    # it 'shows username on page after sign up' do
      visit new_user_path
      fill_in 'Username', with: 'Cookiessssss'  
      fill_in 'Password', with: 'monstersdjhfvo'
      click_button 'Submit!'
      save_and_open_page
      
      expect(page).to have_content('Cookiessssss')  
    # end
  end
end

feature 'loggin in' do
  background :each do 
    visit new_session_path
  end
  
  scenario 'shows username on home page after login' do
    User.create(username: 'Cookie', password: 'monster')
    fill_in 'Username', with: 'Cookie'
    fill_in 'Password', with: 'monster'
    click_button 'Submit!'
    save_and_open_page
    
    expect(page).to have_content('Cookie')  
  end
  
end

feature 'logging out' do
  background :each do 
    # User.create(username: 'Cookie', password: 'monster')
    # login!(cookie)
    visit new_user_path
    fill_in 'Username', with: 'Cookie'
    fill_in 'Password', with: 'monster'
    click_button 'Submit!'
  end
  
  scenario 'begins a logged out state' do
    expect(page).to have_content('Logout!')
  end
  
  scenario 'doesnt show username on page after log out' do
    click_button 'Logout!'
    expect(page).not_to have_content('Cookie')
  end
  
end

#specs wont pass
#this dam auth token




