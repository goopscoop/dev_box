class ToolsController < ApplicationController

  # tools GET
  def index
    search_term = params[:q]
    category = params[:c]
    tag = params[:t]

    # Search results for a query and category
    if search_term && category && tag
      search_match = db_find_by_term_cat_tag category,tag,search_term
      tool_info = add_tool_info search_match
      sort_by_votes tool_info
      render json: tool_info
    elsif search_term && tag
      search_match = db_find_by_tags_and_tool_title tag, search_term
      tool_info = add_tool_info search_match
      sort_by_votes tool_info
      render json: tool_info
    elsif search_term && category
      search_match = db_find_by_cat_and_tool_title category, search_term
      tool_info = add_tool_info search_match
      sort_by_votes tool_info
      render json: tool_info
    elsif category && tag
      search_match = db_find_by_cat_tag category,tag
      tool_info = add_tool_info search_match
      sort_by_votes tool_info
      render json: tool_info
    elsif category
      search_match = db_find_by_cat category
      tool_info = add_tool_info search_match
      sort_by_votes tool_info
      render json: tool_info
    elsif tag
      search_match = db_find_by_tag tag
      tool_info = add_tool_info search_match
      sort_by_votes tool_info
      render json: tool_info
    elsif search_term
      search_match = db_find_by_tool_title search_term
      tag_match = db_find_by_tag_partial_match search_term
      tool_info = add_tool_info search_match
      add_tags_to_tool_info tag_match , tool_info
      sort_by_votes tool_info
      render json: tool_info
    else
      all_tags_and_cats = db_all_tags_and_cats
      render json: { categories: all_tags_and_cats[:cats], tags: all_tags_and_cats[:tags] }
    end
  end

  # tool GET
  def show
    nav_cats = db_all_cats
    nav_tags = get_popular_tags
    tool = db_find_by_tool_id params[:id]
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
    all_tags_and_cats = db_all_tags_and_cats
    render json: {result: {categories: all_tags_and_cats[:cats], tags: all_tags_and_cats[:tags] } || false}
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
      if cid
        c = Category.find(cid)
        tool.categories << c
      end
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
    tool = db_find_by_tool_id params[:id]
    categories = tool.categories
    all_tags_and_cats = db_all_tags_and_cats
    tags = tool.tags
    render json: { tool: tool, categories: categories, tags: tags, allCategories: all_tags_and_cats[:cats], allTags: all_tags_and_cats[:tags] }
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

  def db_find_by_tool_id tool_id
    Tool.find_by_id( tool_id )
  end

  def db_find_by_tag_partial_match search_tag
    Tag.where('tag ilike ?', "%#{search_tag}%")
  end

  def db_find_by_tag search_tag
    Tag.find_by_tag( search_tag ).tools
  end

  def db_find_by_cat search_category
    Category.find_by_category( search_category ).tools
  end

  def db_find_by_cat_and_tool_title search_category, search_title
    Category.find_by_category( search_category ).tools.where('title ilike ?', "%#{search_title}%")
  end

  def db_find_by_tags_and_tool_title search_tag, search_title
    Tag.find_by_tag( search_tag ).tools.where( 'title ilike ?', "%#{search_title}%" )
  end

  def sort_by_votes array_of_tools
    array_of_tools.sort!{ |a,b| b[:votes].to_i <=> a[:votes].to_i }
  end

  def tool_params
    params.require( :tool ).permit( :title,:description,:language,:is_open,:is_free,:web_url,:repo_url,:doc_url,:avg_rating )
  end

  def db_find_by_term_cat_tag category,tag,search_term
    Tool.find_by_sql(["SELECT  t.*
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
      AND t.title ilike ?",category,tag,"%#{search_term}%"])
  end

  def db_find_by_cat_tag category,tag
    Tool.find_by_sql(["SELECT  t.*
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
  end

  def add_tags_to_tool_info tag_match, tool_info
    tag_match.each do |tag|
      tag.tools.each do |tool|
        if tool_info.any? {|t| t[:id] == tool[:id]} == false
          tool_info.push(add_single_tool_info tool)
        end
      end
    end
  end

  def add_tool_info array_of_tools
    tool_info = []
    array_of_tools.each do |tool|
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
      tool_info.push({ id: tool.id, title: tool.title, avg_rating: tool.avg_rating, language: tool.language, tags: tags, categories: cats, votes: tvotes, hasVoted: has_voted, voteId: vote_id, web_url: tool.web_url, repo_url: tool.repo_url, doc_url: tool.doc_url })
    end
    return tool_info
  end

  def add_single_tool_info tool
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
    return({ id: tool.id, title: tool.title, avg_rating: tool.avg_rating, language: tool.language, tags: tags, categories: cats, votes: tvotes, hasVoted: has_voted, voteId: vote_id, web_url: tool.web_url, repo_url: tool.repo_url, doc_url: tool.doc_url })
  end

end
