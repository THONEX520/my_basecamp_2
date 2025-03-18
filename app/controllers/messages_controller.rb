class MessagesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_project
  before_action :set_discussion_thread
  before_action :set_message, only: [:edit, :update, :destroy]

  def new
    @message = @discussion_thread.messages.new
  end

  def index
    @messages = @discussion_thread.messages

    respond_to do |format|
      format.html
      format.json { render json: @messages }
    end
  end

  def create
    @message = @discussion_thread.messages.build(message_params)
    @message.user = current_user

    if @message.save
      redirect_to project_discussion_thread_path(@project, @discussion_thread), notice: "Message posted."
    else
      flash[:alert] = "Message cannot be empty."
      redirect_to project_discussion_thread_path(@project, @discussion_thread)
    end
  end

  def edit
  end

  def show
    @message = @discussion_thread.messages.find(params[:id])
  end

  def update
    if @message.update(message_params)
      redirect_to project_discussion_thread_path(@project, @discussion_thread), notice: "Message was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @message.destroy
    redirect_to project_discussion_thread_path(@project, @discussion_thread), notice: "Message deleted."
  end

  private

  def set_project
    @project = Project.find(params[:project_id])
  end

  def set_discussion_thread
    @discussion_thread = @project.discussion_threads.find(params[:discussion_thread_id])
  end

  def set_message
    @message = @discussion_thread.messages.find(params[:id])
    unless @message.user == current_user
      redirect_to project_discussion_thread_path(@project, @discussion_thread), alert: "You can only edit or delete your own messages."
    end
  end

  def message_params
    params.require(:message).permit(:content)
  end
end
