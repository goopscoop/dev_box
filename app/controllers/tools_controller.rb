class ToolsController < ApplicationController

  def add_tool_info tool
        cats = []
        tool.categories.each do |cat|
          cats.push({ id: cat[:id] , category: cat[:category] })
        end
        tags = []
        tool.tags.each do |tag|
          tags.push({ id: tag[:id] , tag: tag[:tag]})
        end
        return({ id: tool.id, title: tool.title, tags: tags, categories: cats })
  end



  # tools GET
  def index

    tool_info = []
    search_term = params[:q]
    category = params[:c]
    tag = params[:t]

    # Search results for a query and category
    if search_term && category
      categoryMatch = Category.find_by_category(category)
      searchMatch = categoryMatch.tools.where('title ilike ?', "%#{search_term}%")

      # Add tools to json + associated tags and categories
      searchMatch.each do |tool|
        tool_info.push(add_tool_info tool)
      end

      render json: tool_info
    elsif category
      # Just a category search
      categoryMatch = Category.find_by_category(category)
      searchMatch = categoryMatch.tools

      searchMatch.each do |tool|
        tool_info.push(add_tool_info tool)
      end

      render json: tool_info

    elsif search_term
    # Search results for just a query (no categories or tags)
      searchMatch = Tool.where('title ilike ?', "%#{search_term}%")
      tagMatch = Tag.where('tag ilike ?', "%#{search_term}%")

      # Add tools to json + associated tags and categories
      searchMatch.each do |tool|
        tool_info.push(add_tool_info tool)
      end

      # Add tags to seach results then add associated tools and categories
      tagMatch.each do |tag|

        tag.tools.each do |tool|
          # Searches for an instance of this tool in current results, returns object if there, else returns nil
          # if nil, end loop
          if tool_info.any? {|t| t[:id] == tool[:id]}
            return
          else
            tool_info.push(add_tool_info tool)
          end
        end

      end
      render json: tool_info

    else

      all_categories = Category.all
      all_tags = Tag.all
      render json: { categories: all_categories, tags: all_tags }

    end
  end

  # tool GET
  def show

    puts "*************** Show Route ************************"
    # Post.includes([:author, :comments]).where(['comments.approved = ?', true])
    # tool = Tool.find(params[:id]).includes([:categories, :tags])
    tool = Tool.find(params[:id])
    tags = tool.tags
    categories = tool.categories
    tool_info = {tool: tool, tags: tags, categories: categories}
    # posts = Post.includes(:comments).limit(20)
    # tool = Tool.includes(:tags)

#     tool = Tool.find_by_sql("SELECT *
# FROM  tools t,
#   categories_tools ct,
#   categories c,
#   tags_tools tt,
#   tags tg
# WHERE t.id = ct.tool_id
# AND ct.category_id = c.id
# AND t.id = tt.tool_id
# AND tt.tag_id = tg.id
# AND t.id = #{params[:id]}")

    p tool_info
    render json: {result: tool_info || false}

  end

  # new_tool GET
  def new
  end

  # POST
  def create

    tool = Tool.create(title: params[:title], description: params[:description], language: params[:language], is_open: params[:is_open], is_free: params[:is_free], web_url: params[:web_url], repo_url: params[:repo_url], doc_url: params[:doc_url] )

    render json: {result: tool || false}
  end

  # edit_tool GET
  def edit
  end

  # PATCH or PUT
  def update
  end

  # DELETE
  def destroy
  end

  private

  def tool_params
    params.require(:tool).permit(:title,:description,:language,:is_open,:is_free,:web_url,:repo_url,:doc_url,:avg_rating)
  end

end
