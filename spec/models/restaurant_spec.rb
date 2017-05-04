require 'rails_helper'

describe Restaurant, type: :model do

  before do
    User.create(email: "user@name.com", password: 'password', password_confirmation: 'password')
  end

  it 'is not valid with a name of less than 3 characters' do
    user = User.first
    restaurant = user.restaurants.new(name: 'KF')
    expect(restaurant).to have(1).error_on(:name)
    expect(restaurant).not_to be_valid
  end

  it 'is not valid unless it has a unique name' do
    user = User.first
    user.restaurants.create(name: 'Pizza Hut')
    restaurant = user.restaurants.new(name: 'Pizza Hut')
    expect(restaurant).to have(1).error_on(:name)
  end

  context 'associations' do
    it 'should have one to many association with user' do
      should belong_to(:user)
    end
  end


  describe 'build_with_user' do
    let(:user) { User.create email: 'test@test.com' }
    let(:restaurant) { Restaurant.create name: 'Test' }
    let(:review_params) { {rating: 5, thoughts: 'yum'} }

    subject(:review) { restaurant.reviews.build_with_user(review_params, user) }

    it 'builds a review' do
      expect(review).to be_a Review
    end

    it 'builds a review associated with the specified user' do
      expect(review.user).to eq user
    end
  end

  describe '#average rating' do
    it 'returns average rating' do
      user = User.first
      restaurant = user.restaurants.create(name: 'Cat\'s pyjamas')
      user_2 = User.create(email: "second_user@name.com", password: 'password', password_confirmation: 'password')
      restaurant.reviews.create(rating: 1, user: user_2)
      user_3 = User.create(email: "third_user@name.com", password: 'password', password_confirmation: 'password')
      restaurant.reviews.create(rating: 5, user: user_3)
      expect(restaurant.average_rating).to eq 3
    end
  end

end
