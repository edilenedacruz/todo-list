class ProjectsController < ApplicationController
  before_action :set_project, :except => [:index, :new, :create]

  def index
    @projects = Project.all
  end

  def show
  end

  def new
    @project = Project.new
  end

  def edit
  end

  def create
    @project = Project.new(project_params)

    respond_to do |format|
      if @project.save
        format.html { redirect_to project_path(@project),
                      :notice => 'Project was successfully created.' }
      else
        error_messages = @project.errors.full_messages.reduce('') do |full_message, error|
          full_message = error + "\n"
        end
        flash[:error] = error_messages
        format.html { render :action => 'new' }
      end
    end
  end

  def update
    respond_to do |format|
      if @project.update(project_params)
        format.html { redirect_to project_path(@project),
                      :notice => 'Project was successfully updated.' }
      else
        format.html { render :action => 'edit' }
      end
    end
  end

  def destroy
    @project.destroy
    respond_to do |format|
      format.html { redirect_to projects_path,
                    :notice => 'Project was successfully destroyed.' }
    end
  end

  def clear
    @project.items.complete.destroy_all
    respond_to do |format|
      format.html { redirect_to project_path(@project),
                    :notice => 'Completed items were successfully cleared.' }
    end
  end

private
  def set_project
    @project = Project.find(params[:id])
  end

  def project_params
    params.require(:project).permit(:title)
  end
end

