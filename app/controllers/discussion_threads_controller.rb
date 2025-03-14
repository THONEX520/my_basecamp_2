class DiscussionThreadsController < ApplicationController
  before_action :set_project
  before_action :set_discussion_thread, only: %i[edit update destroy]
  before_action :authorize_admin!, only: %i[new create edit update destroy]

  def new
    @discussion_thread = @project.discussion_threads.new
  end

  def create
    @discussion_thread = @project.discussion_threads.build(discussion_thread_params)
    @discussion_thread.user = current_user

    if @discussion_thread.save
      redirect_to @project, notice: "Thread created successfully."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    if @discussion_thread.update(discussion_thread_params)
      redirect_to @project, notice: "Thread updated successfully."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @discussion_thread.destroy
    redirect_to @project, notice: "Thread deleted successfully."
  end

  private

  def set_project
    @project = Project.find(params[:project_id])
  end

  def set_discussion_thread
    @discussion_thread = @project.discussion_threads.find(params[:id])
  end

  def discussion_thread_params
    params.require(:discussion_thread).permit(:title, :content)
  end

  def authorize_admin!
    unless current_user.has_role?(:admin)
      redirect_to @project, alert: "Only admins can manage discussion threads."
    end
  end
end
