class CollectionsController < ApplicationController

  def index
    # get collection info
  end

  def new
    # show page for new collection (form)
    all_tags_and_cats = db_all_tags_and_cats
    render json: {result: {categories: all_tags_and_cats[:cats], tags: all_tags_and_cats[:tags] } || false}
  end

  def create
    # add new tool to a collection
  end

  def show
    # get all tools for single collection
  end

  def edit
  end

end
