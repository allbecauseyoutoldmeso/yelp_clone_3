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
      @review = @restaurant.build_review(review_params, current_user)
      @review.save
      redirect_to '/restaurants'
    end
  end

  private



  def review_params
    params.require(:review).permit(:thoughts, :rating)
  end

end
