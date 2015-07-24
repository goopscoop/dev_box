class CollectionsController < ApplicationController

  def index
    # get collection info
  end

  def new
    all_tags_and_cats = db_all_tags_and_cats
    render json: {result: {categories: all_tags_and_cats[:cats], tags: all_tags_and_cats[:tags] } || false}
  end

  def create
    if current_user
      collection = Collection.create( name: params[:name], description: params[:description], is_public: params[:is_public] )
      current_user.collections << collection

      user_tools = current_user.tools

      params[:tools].each do |tool|
        add_tool = Tool.find_by_id( tool[:id] )
        if user_tools.any? {|a| a[:id] == tool[:id]} == false
          user_tools << add_tool
        end
        collection.tools << add_tool
      end

      render json: { result: true, id: collection.id }
    else
      render json: { result: false }
    end
  end

  def show
    collection = Collection.find_by_id( params[:id] )
    if collection[:is_public] == true
      tools = add_tool_categories collection.tools
      render json: { result: true, collection: collection, tools: tools }
    else
      render json: { result: false}
    end
  end

  def edit
  end

  private

  def tool_collections
    params.require( :collection ).permit( :name,:description,:is_public )
  end

end
