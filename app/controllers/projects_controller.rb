class ProjectsController < ApplicationController
  before_action :set_project, only: %i[ show edit update destroy ]
  before_action :authenticate_user!, except: [:index, :show]
  before_action :correct_user, only: [:edit, :update, :destroy]
  

  def index
    @projects = Project.includes(:user).all
  end

  def show
  end

  def new
    @project = current_user.projects.build
  end

  def edit
  end

  def create
    @project = current_user.projects.build(project_params)

    respond_to do |format|
      if @project.save
        format.html { redirect_to @project, notice: "Project was successfully created." }
        format.json { render :show, status: :created, location: @project }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @project.update(project_params)
        format.html { redirect_to @project, notice: "Project was successfully updated." }
        format.json { render :show, status: :ok, location: @project }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @project = Project.find(params[:id])
    @project.destroy
    redirect_to projects_path, notice: "Project was successfully deleted."
  end

  def correct_user
    @project = Project.find_by(id: params[:id])  
    unless @project && (current_user == @project.user || current_user.has_role?(:admin))
      redirect_to projects_path, alert: "Not Authorized to Edit or Delete This Project"
    end
  end
  

  private

  def authorize_user
    unless current_user && (current_user.has_role?(:admin) || current_user.has_role?(:user))
      redirect_to root_path, alert: "Access Denied"
    end
  end

  def set_project
    @project = Project.find(params.require(:id))
  end

  def project_params
    params.require(:project).permit(:name, :description, :user_id)
  end
end
