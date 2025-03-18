class MessagesController < ApplicationController
  before_action :set_discussion_thread
  before_action :set_message, only: [:edit, :update, :destroy]
  before_action :authenticate_user!

  def new
    @message = @discussion_thread.messages.new
  end

  def create
    Rails.logger.debug "Params received: #{params.inspect}" 
    
    @message = @discussion_thread.messages.new(message_params)
    @message.user = current_user

    if @message.save
      redirect_to @discussion_thread, notice: "Message posted successfully."
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @message.update(message_params)
      redirect_to @discussion_thread, notice: "Message updated."
    else
      render :edit
    end
  end

  def destroy
    @message.destroy
    redirect_to @discussion_thread, notice: "Message deleted."
  end

  private

  def set_discussion_thread
    @discussion_thread = DiscussionThread.find(params[:discussion_thread_id])
  end

  def set_message
    @message = @discussion_thread.messages.find(params[:id])
  end

  def message_params
    params.require(:message).permit(:content)
  end
end
