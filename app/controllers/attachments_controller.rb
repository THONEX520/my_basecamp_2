class AttachmentsController < ApplicationController
  before_action :set_project
  before_action :authenticate_user!

  def create
    @attachment = @project.attachments.new(attachment_params)
    if @attachment.save
      redirect_to @project, notice: 'Attachment added successfully.'
    else
      redirect_to @project, alert: 'Failed to add attachment.'
    end
  end

  def destroy
    @attachment = @project.attachments.find(params[:id])
    @attachment.destroy
    redirect_to @project, notice: 'Attachment removed successfully.'
  end

  private

  def set_project
    @project = Project.find(params[:project_id])
  end

  def attachment_params
    params.require(:attachment).permit(:file)
  end
end
