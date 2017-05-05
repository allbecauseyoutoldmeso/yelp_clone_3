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

  context 'restaurants have been added' do
    before do
      create_restaurant('KFC', 'nice')
    end

    scenario 'display restaurants' do
      visit '/restaurants'
      expect(page).to have_content 'KFC'
      expect(page).not_to have_content 'No restaurants yet'
    end
  end

  context 'creating restaurants' do
    scenario 'prompt user to fill out a form, then displays the new restaurant' do
      add_restaurant('KFC')
      expect(page).to have_content 'KFC'
      expect(current_path).to eq '/restaurants'
    end

    context 'an invalid restaurant' do
      scenario 'does not let you submit a name that is too short' do
        add_restaurant('KF')
        expect(page).not_to have_css 'h2', text: 'KF'
        expect(page).to have_content 'error'
      end
    end

    context 'user not logged in' do
      scenario 'redirect to login page' do
        click_link 'Sign out'
        visit '/restaurants'
        click_link 'Add a restaurant'
        expect(page).to have_content 'You need to sign in or sign up before continuing'
      end
    end
  end

  context 'viewing restaurants' do
    before do
      create_restaurant('KFC', 'nice')
    end

    scenario 'lets a user view a restaurant' do
      visit '/restaurants'
      click_link 'KFC'
      expect(page).to have_content 'KFC'
      expect(current_path).to eq "/restaurants/#{Restaurant.last.id}"
    end
  end

  context 'editing restaurants' do
    before do
      create_restaurant('KFC', 'so so')
    end
    scenario 'let a user edit a restaurant' do
      edit_restaurant('KFC', 'Kentucky Fried Chicken', 'deep fried goodness')
      # visit '/restaurants'
      # click_link 'Edit KFC'
      # fill_in 'Name', with: 'Kentucky Fried Chicken'
      # fill_in 'Description', with: 'deep fried goodness'
      # click_button 'Update Restaurant'
      click_link 'Kentucky Fried Chicken'
      expect(page).to have_content 'Kentucky Fried Chicken'
      expect(page).to have_content 'deep fried goodness'
      expect(current_path).to eq "/restaurants/#{Restaurant.last.id}"
    end
  end

  context 'deleting restaurants' do
    before do
      create_restaurant('KFC', 'nice')
    end
    scenario 'removes the restaurant when user clicks delete link' do
      visit '/restaurants'
      click_link 'Delete KFC'
      expect(page).not_to have_content 'KFC'
      expect(page).to have_content 'Restaurant deleted successfully'
    end
  end

end
