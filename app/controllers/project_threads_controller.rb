class ProjectThreadsController < ApplicationController
  before_action :set_project
  before_action :authenticate_user!
  before_action :check_admin, only: [:new, :create]

  def new
    @project_thread = @project.project_threads.build
  end

  def create
    @project_thread = @project.project_threads.build(thread_params.merge(user: current_user))
    if @project_thread.save
      redirect_to @project, notice: "Thread created successfully."
    else
      render :new
    end
  end

  def edit
    @project_thread = @project.project_threads.find(params[:id])
  end

  def update
    @project_thread = @project.project_threads.find(params[:id])
    if @project_thread.update(thread_params)
      redirect_to @project, notice: "Thread updated."
    else
      render :edit
    end
  end

  def destroy
    @project_thread = @project.project_threads.find(params[:id])
    @project_thread.destroy
    redirect_to @project, notice: "Thread deleted."
  end

  private

  def set_project
    @project = Project.find(params[:project_id])
  end

  def thread_params
    params.require(:project_thread).permit(:title, :content)
  end

  def check_admin
    redirect_to @project, alert: "Only admins can create threads." unless current_user.admin?
  end
end