class ApplicationController < ActionController::Base

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.

  # Rails CSRF Protection + Angular.js
  # http://stackoverflow.com/questions/14734243/rails-csrf-protection-angular-js-protect-from-forgery-makes-me-to-log-out-on

  protect_from_forgery with: :exception

  before_action :current_user

  after_filter :set_csrf_cookie_for_ng

  def is_authenticated?
    unless current_user
      flash[:danger] = "Please sign up or log in"
      redirect_to root_path
    end
  end

  def current_user
    @current_user ||= User.find_by_id(session[:user_id])
  end

  def set_csrf_cookie_for_ng
    cookies['XSRF-TOKEN'] = form_authenticity_token if protect_against_forgery?
  end

  protected

  # In Rails 4.2 and above
  def verified_request?
    super || valid_authenticity_token?(session, request.headers['X-XSRF-TOKEN'])
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

  def add_tool_categories array_of_tools
    tool_info = []
    array_of_tools.each do |tool|
      cats = []
      tool.categories.each do |cat|
        cats.push({ id: cat[:id] , category: cat[:category] })
      end
      tool_info.push({ id: tool.id, title: tool.title, avg_rating: tool.avg_rating, language: tool.language, categories: cats, web_url: tool.web_url, repo_url: tool.repo_url, doc_url: tool.doc_url })
    end
    return tool_info
  end

  def get_popular_tags
    Tag.find_by_sql("SELECT    tt.tag_id, t.tag, count(tt.tag_id)
                      FROM    tags_tools tt,
                          tags t
                      WHERE    tt.tag_id = t.id
                      GROUP BY tt.tag_id, t.tag
                      ORDER BY count(tag_id) desc
                      LIMIT 10")
  end

  def db_get_tool tool_id
    Tool.find_by_id( tool_id )
  end

  def db_all_tags_and_cats
    { tags: db_all_tags, cats: db_all_cats }
  end

  def db_popular_tags_and_cats
    { tags: get_popular_tags, cats: db_all_cats }
  end

  def db_all_tags
    Tag.all
  end

  def db_all_cats
    Category.all
  end

  def db_find_by_tool_title search_title
    Tool.where('title ilike ?', "%#{search_title}%")
  end

  def db_get_collection id
    Collection.find_by_id( id )
  end

end
