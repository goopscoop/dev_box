class ReviewsController < ApplicationController

  # tool_reviews POST
  def create

    if current_user
      if params[:rating]
        review = Review.create(post: params[:post], rating: params[:rating], user_id: current_user[:id], tool_id: params[:tool_id])
      else
        review = Review.create(post: params[:post], user_id: current_user[:id], tool_id: params[:tool_id])
      end

      review_user = {review: review, user_name: current_user[:name]}
      render json: {result: review_user || false}
    else
      render json: {result: false}
    end
  end

  # tool_review PATCH or PUT
  def update

    if current_user
      review = Review.find(params[:id])

      if params[:rating]
        # if the rating is passed in, update the rating
        review.rating = params[:rating]
        review.save
      else
        # Otherwise update the review
        review.post = params[:post]
        review.save
      end
      render json: {result: true}
    else
      render json: {result: false}
    end
  end

  # tool_review DELETE
  def destroy
  end

end
