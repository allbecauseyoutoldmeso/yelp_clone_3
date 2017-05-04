require 'rails_helper'

feature 'endorsing reviews' do
  before do
    user = User.create(email: "user@name.com", password: 'password', password_confirmation: 'password')
    restaurant = user.restaurants.create(name: 'Cat\'s pyjamas')
    user_2 = User.create(email: "second_user@name.com", password: 'password', password_confirmation: 'password')
    restaurant.reviews.create(rating: 1, user: user_2)
  end

  scenario 'a user can endorse a review, which updates the review endorsement count' do
    create_user('kate@kate.com')
    sign_in('kate@kate.com')
    visit '/restaurants'
    click_link 'Endorse Review'
    expect(page).to have_content('1 endorsement')
  end

end
