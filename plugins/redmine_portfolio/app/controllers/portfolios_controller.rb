class PortfoliosController < ApplicationController
  include PortfoliosHelper

  def index
    retrieve_default_query
    retrieve_project_query
    @portfolio_project = Project.all
    scope = portfolio_scope

    @portfolio_project_count = @portfolio_project.count
    @portfolio_project_pages = Paginator.new @portfolio_project_count, per_page_option, params['page']
    @portfolio_project = @portfolio_project.limit(@portfolio_project_pages.per_page).offset(@portfolio_project_pages.offset).to_a
    respond_to do |format|
      format.html do
        if @query.display_type == 'board'
          @portfolio_project = scope.to_a
        else
          @entry_count = scope.count
          @entry_pages = Paginator.new @entry_count, per_page_option, params['page']
          @portfolio_project = scope.offset(@entry_pages.offset).limit(@entry_pages.per_page).to_a
        end
      end
    end
  end

  def portfolio_projects
    @portfolio_project = Project.all
    @portfolio_status = params[:status] || 1

    scope = Project.status(@portfolio_status).sorted
    scope = scope.like(params[:name]) if params[:name].present?

    @project_count = scope.count
    @project_pages = Paginator.new @project_count, per_page_option, params['page']
    @projects = scope.limit(@project_pages.per_page).offset(@project_pages.offset).to_a

    render :action => "portfolio_projects", :layout => false if request.xhr?
  end

  private

  def portfolio_scope(options = {})
    @query.results_scope(options)
  end

  def retrieve_project_query
    retrieve_query(ProjectQuery, false, :defaults => @default_columns_names)
  end

  def retrieve_default_query
    return if params[:query_id].present?
    return if api_request?
    return if params[:set_filter]

    if params[:without_default].present?
      params[:set_filter] = 1
      return
    end

    if default_query = ProjectQuery.default
      params[:query_id] = default_query.id
    end
  end
end