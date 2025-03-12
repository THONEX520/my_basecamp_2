class MessagesController < ApplicationController
  before_action :set_project_thread
  before_action :authenticate_user!

  def create
    @message = @project_thread.messages.build(message_params.merge(user: current_user))
    if @message.save
      redirect_to @project_thread.project, notice: "Message posted."
    else
      redirect_to @project_thread.project, alert: "Failed to post message."
    end
  end

  def edit
    @message = @project_thread.messages.find(params[:id])
  end

  def update
    @message = @project_thread.messages.find(params[:id])
    if @message.update(message_params)
      redirect_to @project_thread.project, notice: "Message updated."
    else
      render :edit
    end
  end

  def destroy
    @message = @project_thread.messages.find(params[:id])
    @message.destroy
    redirect_to @project_thread.project, notice: "Message deleted."
  end

  private

  def set_project_thread
    @project_thread = ProjectThread.find(params[:project_thread_id])
  end

  def message_params
    params.require(:message).permit(:content)
  end
end
