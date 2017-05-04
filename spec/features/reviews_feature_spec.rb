require 'rails_helper'

feature 'reviewing' do
  before do
    User.create(email: "user@name.com", password: 'password', password_confirmation: 'password')
    user = User.first
    user.restaurants.create(name: 'KFC')
    User.create(email: "anotheruser@name.com", password: 'password', password_confirmation: 'password')
    visit '/'
    click_link 'Sign in'
    fill_in 'Email', with: "anotheruser@name.com"
    fill_in 'Password', with: 'password'
    click_button 'Log in'
  end
  scenario 'allows users to leave a review using a form' do
    visit '/restaurants'
    click_link 'Review KFC'
    fill_in 'Thoughts', with: 'so so'
    select '3', from: 'Rating'
    click_button 'Leave Review'
    expect(current_path).to eq '/restaurants'
    expect(page).to have_content('so so')
  end
  scenario 'can see average review rating' do
    visit '/restaurants'
    leave_review('so so', '1')
    click_link 'Sign out'
    create_user('athirduser@name.com')
    sign_in('athirduser@name.com')
    leave_review('bleh', '5')
    expect(page).to have_content('Average rating: 3')
  end
end
