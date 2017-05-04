class ReviewsController < ApplicationController

  def new
    @restaurant = Restaurant.find(params[:restaurant_id])
    @review = Review.new
  end

  def create
    @restaurant = Restaurant.find(params[:restaurant_id])
    @review = @restaurant.build_review(review_params, current_user)
    # @review = @restaurant.reviews.new(thoughts: review_params[:thoughts], rating: review_params[:rating], user: current_user)
    if @review.save
      redirect_to '/restaurants'
    else
      flash[:notice] = 'You have already reviewed this restaurant'
      redirect_to '/restaurants'
    end
  end

  private

  def review_params
    params.require(:review).permit(:thoughts, :rating)
  end

end
