require 'rails_helper'

feature 'Restaurants' do

  before do
    create_user("user@name.com")
    sign_in("user@name.com")
  end

  context 'no restaurants have been added' do

    scenario 'should display a prompt to add a restaurant' do
      visit '/restaurants'
      expect(page).to have_content 'No restaurants yet'
      expect(page).to have_link 'Add a restaurant'
    end

  end

  context 'creating restaurants' do

    scenario 'prompt user to fill out a form, then displays the new restaurant' do
      add_restaurant('KFC')
      expect(page).to have_content 'KFC'
      expect(current_path).to eq '/restaurants'
    end

    scenario 'redirect to login page if not logged in' do
      click_link 'Sign out'
      visit '/restaurants'
      click_link 'Add a restaurant'
      expect(page).to have_content 'You need to sign in or sign up before continuing'
    end

    scenario 'does not let you submit a name that is too short' do
      add_restaurant('KF')
      expect(page).not_to have_css 'h2', text: 'KF'
      expect(page).to have_content 'error'
    end

  end

  context 'restaurants have been added' do

    before do
      create_restaurant('KFC', 'nice')
    end

    scenario 'display restaurants' do
      visit '/restaurants'
      expect(page).to have_content 'KFC'
      expect(page).not_to have_content 'No restaurants yet'
    end

    scenario 'lets a user view a restaurant' do
      visit '/restaurants'
      click_link 'KFC'
      expect(page).to have_content 'KFC'
      expect(current_path).to eq "/restaurants/#{Restaurant.last.id}"
    end

    scenario 'let a user edit a restaurant' do
      edit_restaurant('KFC', 'Kentucky Fried Chicken', 'greasy')
      click_link 'Kentucky Fried Chicken'
      expect(page).to have_content 'Kentucky Fried Chicken'
      expect(page).to have_content 'greasy'
      expect(current_path).to eq "/restaurants/#{Restaurant.last.id}"
    end

    scenario 'removes the restaurant when user clicks delete link' do
      visit '/restaurants'
      click_link 'Delete KFC'
      expect(page).not_to have_content 'KFC'
      expect(page).to have_content 'Restaurant deleted successfully'
    end

  end
  
end
