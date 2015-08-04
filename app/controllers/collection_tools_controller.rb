class CollectionToolsController < ApplicationController

  def update
    collection = db_get_collection params[:collection_id]
    tool = db_get_tool params[:id]
    collection.tools << tool
    render json: {result: true}
  end

end
