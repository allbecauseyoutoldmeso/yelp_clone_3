class Restaurant < ApplicationRecord
  has_many :reviews,
      -> { extending WithUserAssociationExtension },
      dependent: :destroy
  belongs_to :user
  validates :name, length: { minimum: 3}, uniqueness: true

  def build_review(review_params, user)
    review = reviews.new(review_params)
    review.user = user
    review
  end

  def average_rating
    return 'N/A' if reviews.none?
    reviews.average(:rating)
  end

end
