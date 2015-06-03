class StaticController < ApplicationController

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

  def index
    popular_tools = []
    popular_votes = Tvote.find_by_sql("SELECT tool_id, sum(vote)
                                FROM tvotes
                                Group by tool_id
                                Order by sum(vote) desc
                                LIMIT 5")
    popular_votes.each do |vote|
      popular_tools.push(add_tool_info Tool.find_by_id(vote.tool_id))
    end
    recent_tools = []
    tools = Tool.limit(5).order('id desc')
    tools.each do |tool|
      recent_tools.push(add_tool_info tool)
    end

    categories = Category.all
    tags = Tag.all

    render json: { categories: categories, tags: tags, popular:popular_tools, recent: recent_tools }
  end
end
