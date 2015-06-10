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
          if current_user && vote.user_id == current_user.id
            has_voted = true
            vote_id = vote.id
          end
        end

        return({ id: tool.id, title: tool.title, avg_rating: tool.avg_rating, language: tool.language, tags: tags, categories: cats, votes: tvotes, hasVoted: has_voted, voteId: vote_id })
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
      search_match.each do |tool|
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
      all_tags = get_popular_tags
      render json: { categories: all_categories, tags: all_tags }
    end
  end

  # tool GET
  def show
    nav_cats = Category.all
    nav_tags = get_popular_tags
    tool = Tool.find(params[:id])
    tags = tool.tags
    categories = tool.categories
    reviews = tool.reviews.order(created_at: :desc)

    reviews_users = reviews.map do |r|
      user_name = User.find(r[:user_id])[:name]
      {review: r, user_name: user_name}
    end

    if current_user
      favorited = current_user.tools.find_by_id(params[:id]) ? true : false
      tool_info = { tool: tool, tags: tags, categories: categories, reviews_users: reviews_users, favorited: favorited }
    else
      tool_info = { tool: tool, tags: tags, categories: categories, reviews_users: reviews_users, favorited: false }
    end
    render json: { result: tool_info, navCats: nav_cats, navTags: nav_tags }

  end

  # new_tool GET
  def new
    categories = Category.all
    tags = Tag.all
    tag_tags = tags.map do |tag|
      {tag: tag[:tag]}
    end

    render json: {result: {categories: categories, tags: tag_tags} || false}

  end

  # POST
  def create

    # Create the tool
    tool = Tool.create(title: params[:title], description: params[:description],
                      language: params[:language], is_open: params[:is_open],
                      is_free: params[:is_free], web_url: params[:web_url],
                      repo_url: params[:repo_url], doc_url: params[:doc_url] )

    # Associate the categories to the new tool
    params[:categories].each do |cid|
      c = Category.find(cid)
      tool.categories << c
    end

    # Associate existing tags to the new tool
    # If a tag does not already exist; create it
    # and then associate it to the new tool
    params[:tags].each do |tag_obj|
      t = Tag.find_by_tag(tag_obj[:tag].downcase)

      unless t
        t = Tag.create(tag: tag_obj[:tag].downcase)
      end

      tool.tags << t
    end

    render json: {result: tool || false}

  end

  # edit_tool GET
  def edit
    tool = Tool.find_by_id(params[:id])
    categories = tool.categories
    all_categories = Category.all
    tags = tool.tags
    all_tags = Tag.all
    render json: { tool: tool, categories: categories, tags: tags, allCategories: all_categories, allTags: all_tags }
  end

  # PATCH or PUT
  def update

    if current_user
      tool = Tool.find_by_id(params[:id])
      tool.title = params[:title]
      tool.description = params[:description]
      tool.language = params[:language]
      tool.is_open = params[:is_open]
      tool.is_free = params[:is_free]
      tool.web_url = params[:web_url]
      tool.repo_url = params[:repo_url]
      tool.doc_url = params[:doc_url]
      tool.save

      cur_cats = tool.categories
      new_cats = params[:categories]

      cur_tags = tool.tags
      new_tags = params[:tags]

      cur_tags.each do |cur|
        if new_tags.any? {|h| h[:id] == cur[:id]} == false
          # if cur tag is not in new tags; remove the current tag from the tool
          tool.tags.find(cur[:id]).destroy
        else
          # if the cur tag is still in the new tags, remove it from the new tags
          # array so that we will only be left with actual new tags at the end
          idx = new_tags.index { |h| h[:id] == cur.id }
          new_tags.slice!(idx,1)
        end
      end

      new_tags.each do |tag|
        if tag[:id]
          tool.tags << Tag.find_by_id(tag[:id])
        else
          create = Tag.create({tag: tag[:tag]})
          tool.tags << create
        end
      end

      cur_cats.each do |cur|
        if new_cats.include?(cur.id)
          idx = new_cats.index(cur.id)
          new_cats.slice!(idx,1)
        else
          category = tool.categories.find_by_category(cur.category)
          tool.categories.destroy(category)
        end
      end

      new_cats.each do |cat|
        tool.categories << Category.find(cat)
      end

      render json: {result: true}
    else
      render json: {result: false}
    end
  end

  # DELETE
  def destroy
  end

  private

  def tool_params
    params.require(:tool).permit(:title,:description,:language,:is_open,:is_free,:web_url,:repo_url,:doc_url,:avg_rating)
  end

end
