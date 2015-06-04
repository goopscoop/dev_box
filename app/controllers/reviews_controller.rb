class ReviewsController < ApplicationController

  # tool_reviews POST
  def create

    if current_user
      review = Review.create(post: params[:post], user_id: current_user[:id], tool_id: params[:tool_id])
      review_user = {review: review, user_name: current_user[:name]}
      render json: {result: review_user || false}
    else
      render json: {result: false}
    end
  end

  # tool_review PATCH or PUT
  def update
  end

  # tool_review DELETE
  def destroy
  end

end
