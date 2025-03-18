class DiscussionThreadsController < ApplicationController
  before_action :set_project
  before_action :set_discussion_thread, only: [:edit, :update, :destroy]
  before_action :authorize_admin, only: [:new, :create, :edit, :update, :destroy]

  def new
    @discussion_thread = @project.discussion_threads.new
  end

  def show
    @discussion_thread = DiscussionThread.find(params[:id])
    @messages = @discussion_thread.messages # Ensure @messages is set
    @message = @discussion_thread.messages.build # For the form
  end
  
  

  def create
    @discussion_thread = @project.discussion_threads.new(discussion_thread_params)
    @discussion_thread.user = current_user 

    if @discussion_thread.save
      redirect_to @project, notice: "Discussion thread created successfully."
    else
      flash[:alert] = "Error: Could not create discussion thread."
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
    redirect_to @project, notice: "Thread deleted."
  end

  private

  def set_project
    @project = Project.find(params[:project_id])
  end

  def set_discussion_thread
    @discussion_thread = @project.discussion_threads.find(params[:id])
  end

  def discussion_thread_params
    params.require(:discussion_thread).permit(:title)
  end

  def authorize_admin
    unless current_user.has_role?(:admin, @project) || @discussion_thread.user == current_user
      redirect_to @project, alert: "Only admins or thread creators can manage threads."
    end
  end   
end
