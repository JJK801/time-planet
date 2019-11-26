class ProjectsController < ApplicationController

  def index
    highlighted_project_id = HighlightedContent.first.project_id
    @projects = Project.where(published: true)
                  .where.not(id: highlighted_project_id)
                  .order(created_at: :desc)
    @highlighted_project = Project.find(highlighted_project_id)
  end

  def show
    @project = Project.find_by!(slug: params[:slug])
    @recent_projects = Project.last(4)
  end
end
