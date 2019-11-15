class ProjectsController < ApplicationController

  def index
    @projects = Project.where(published: true).order(created_at: :desc) # .page params[:page]
    @highlighted_project = Project.first # TODO: Handle highlighted content on CMS part
  end

  def show
    @project = Project.find_by!(slug: params[:slug])
    @recent_projects = Project.last(4)
  end
end
