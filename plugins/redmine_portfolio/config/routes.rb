# Plugin's routes
# See: http://guides.rubyonrails.org/routing.html
if Redmine::Plugin.installed? 'redmine_portfolio'
  RedmineApp::Application.routes.draw do
    get 'portfolios', to: 'portfolios#index'
    get 'portfolio_projects', :to => 'portfolios#portfolio_projects'
  end
end