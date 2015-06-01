class ToolsController < ApplicationController

  # tools GET
  def index

    tool_info = []
    search_term = params[:q]

    if search_term
      searchMatch = Tool.where('title ilike ?', "%#{search_term}%")
      searchMatch.each do |tool|
        cats = []
        tool.categories.each do |cat|
          cats.push({ id: cat[:id] , category: cat[:category] })
        end
        tags = []
        tool.tags.each do |tag|
          tags.push({ id: tag[:id] , tag: tag[:tag]})
        end
        tool_info.push({title: tool.title, tags: tags, categories: cats})
      end

        render json: tool_info

    else

      all_tools = Tool.all

      all_tools.each do |tool|

        cats = []
        tool.categories.each do |cat|
          cats.push({ id: cat[:id] , category: cat[:category] })
        end

        tags = []
        tool.tags.each do |tag|
          tags.push({ id: tag[:id] , tag: tag[:tag]})
        end

        tool_info.push({ title: tool.title, tags: tags, categories: cats })
      end

      render json: tool_info

    end
  end

  # tool GET
  def show
  end

  # new_tool GET
  def new
  end

  # POST
  def create
    # @student = Student.where(email:student_params['email'], user_id: student_params['user_id']).first_or_create(student_params)
    # if Student.where(email:student_params['email'], user_id: student_params['user_id']).count > 0
    #   flash[:danger] = 'Student email already exists'
    #   redirect_to new_student_path
    # else
    #   Student.create(student_params)
    #   redirect_to students_path
    # end
    # p {'tool_params' => tool_params}
    # p {'params' => params}

    p params
    # p tool_params

    # user = User.create(name: "David", occupation: "Code Artist")
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
