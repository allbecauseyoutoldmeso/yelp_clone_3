require 'rails_helper'

feature 'reviewing' do
  before do
    create_user("user@name.com")
    create_restaurant('KFC', 'greasy')
    create_user("anotheruser@name.com")
    sign_in("anotheruser@name.com")
  end
  scenario 'allows users to leave a review using a form' do
    leave_review('KFC', 'so so', '3')
    expect(current_path).to eq '/restaurants'
    expect(page).to have_content('so so')
  end
  scenario 'can see average review rating' do
    leave_review('KFC', 'so so', '1')
    click_link 'Sign out'
    create_user('athirduser@name.com')
    sign_in('athirduser@name.com')
    leave_review('KFC', 'bleh', '5')
    expect(page).to have_content('Average rating: 3')
  end
end
