require 'rails_helper'

describe Review, type: :model do

  it 'is invalid if the rating is more than 5' do
    review = Review.new(rating: 10)
    expect(review).to have(1).error_on(:rating)
  end

  context 'associations' do

    it 'should belong to a user' do
      should belong_to :user
    end

    it 'should belong to a restaurant' do
      should belong_to :restaurant
    end

  end

end
