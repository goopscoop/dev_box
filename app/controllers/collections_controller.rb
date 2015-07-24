class CollectionsController < ApplicationController

  def index
    # get collection info
  end

  def new
    all_tags_and_cats = db_all_tags_and_cats
    render json: {result: {categories: all_tags_and_cats[:cats], tags: all_tags_and_cats[:tags] } || false}
  end

  def create
    # add new tool to a collection
    if current_user
      collection = Collection.create( name: params[:name], description: params[:description], is_public: params[:is_public] )
      current_user.collections << collection
      render json: { result: true }
    else
      render json: { result: false }
    end
  end

  def show
    # get all tools for single collection
  end

  def edit
  end

  private

  def tool_collections
    params.require( :collection ).permit( :name,:description,:is_public )
  end

end
