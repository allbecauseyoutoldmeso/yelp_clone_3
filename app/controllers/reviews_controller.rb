class ReviewsController < ApplicationController

  def new
    @restaurant = Restaurant.find(params[:restaurant_id])
    @review = Review.new
  end

  def create

    @restaurant = Restaurant.find(params[:restaurant_id])
    if current_user.has_reviewed?(@restaurant)
      flash[:notice] = 'You have already reviewed this restaurant'
      redirect_to restaurants_path
    else
      @review = @restaurant.reviews.create(thoughts: review_params[:thoughts], rating: review_params[:rating], user: current_user)
      redirect_to '/restaurants'
    end
  end

  private

  def review_params
    params.require(:review).permit(:thoughts, :rating)
  end

end
