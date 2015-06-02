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
        tvotes = 0
        has_voted = false
        vote_id = nil
        tool.tvotes.each do |vote|
          tvotes += vote.vote
          if vote.user_id == current_user.id
            has_voted = true
            vote_id = vote.id
          end
        end

        return({ id: tool.id, title: tool.title, tags: tags, categories: cats, votes: tvotes, hasVoted: has_voted, voteId: vote_id })
  end




  # tools GET
  def index
    tool_info = []
    search_term = params[:q]
    category = params[:c]
    tag = params[:t]

    # Search results for a query and category
    if search_term && category && tag
      search_match = Tool.find_by_sql(["SELECT  t.*
            FROM  tools t,
              categories_tools ct,
              categories c,
              tags_tools tt,
              tags tg
            WHERE t.id = ct.tool_id
            AND ct.category_id = c.id
            AND t.id = tt.tool_id
            AND tt.tag_id = tg.id
            AND c.category = ?
            AND tg.tag = ?
            AND t.title ilike ?",category,tag,search_term])

      search_match.each do |tool|
        tool_info.push(add_tool_info tool)
      end

      tool_info.sort!{ |a,b| b[:votes].to_i <=> a[:votes].to_i }
      render json: tool_info
    elsif search_term && tag
      tag_match = Tag.find_by_tag(tag)
      search_match = tag_match.tools.where('title ilike ?', "%#{search_term}%")
      searchMatch.each do |tool|
        tool_info.push(add_tool_info tool)
      end
      tool_info.sort!{ |a,b| b[:votes].to_i <=> a[:votes].to_i }
      render json: tool_info
    elsif search_term && category
      category_match = Category.find_by_category(category)
      search_match = category_match.tools.where('title ilike ?', "%#{search_term}%")
      # Add tools to json + associated tags and categories
      search_match.each do |tool|
        tool_info.push(add_tool_info tool)
      end
      tool_info.sort!{ |a,b| b[:votes].to_i <=> a[:votes].to_i }
      render json: tool_info
    elsif category && tag

      search_match = Tool.find_by_sql(["SELECT  t.*
      FROM  tools t,
        categories_tools ct,
        categories c,
        tags_tools tt,
        tags tg
      WHERE t.id = ct.tool_id
      AND ct.category_id = c.id
      AND t.id = tt.tool_id
      AND tt.tag_id = tg.id
      AND c.category = ?
      AND tg.tag = ?",category,tag])
      print search_match
      # Add tools to json + associated tags and categories
      search_match.each do |tool|
        tool_info.push(add_tool_info tool)
      end

      tool_info.sort!{ |a,b| b[:votes].to_i <=> a[:votes].to_i }
      render json: tool_info

    elsif category
      # Just a category search
      category_match = Category.find_by_category(category)

      search_match = category_match.tools

      search_match.each do |tool|
        tool_info.push(add_tool_info tool)
      end
      tool_info.sort!{ |a,b| b[:votes].to_i <=> a[:votes].to_i }
      render json: tool_info
    elsif tag
      tag_match = Tag.find_by_tag(tag)
      search_match = tag_match.tools
      searchMatch.each do |tool|
        tool_info.push(add_tool_info tool)
      end
      tool_info.sort!{ |a,b| b[:votes].to_i <=> a[:votes].to_i }
      render json: tool_info
    elsif search_term
    # Search results for just a query (no categories or tags)
      search_match = Tool.where('title ilike ?', "%#{search_term}%")
      tag_match = Tag.where('tag ilike ?', "%#{search_term}%")
      # Add tools to json + associated tags and categories
      search_match.each do |tool|
        tool_info.push(add_tool_info tool)
      end
      # Add tags to seach results then add associated tools and categories
      tag_match.each do |tag|
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
      tool_info.sort!{ |a,b| b[:votes].to_i <=> a[:votes].to_i }
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
    categories = Category.all
    tags = Tag.all

    render json: {result: {categories: categories, tags: tags} || false}
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
