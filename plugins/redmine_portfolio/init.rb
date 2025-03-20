Redmine::Plugin.register :redmine_portfolio do
  name 'Redmine Portfolio plugin'
  author 'Essence Solusoft'
  description 'This is a plugin for Portfolio Tracking'
  version '0.0.1'
  url 'https://essencesolusoft.com/'
  author_url 'https://essencesolusoft.com/'

  requires_redmine version_or_higher: '5.0.0'

  menu :top_menu, :portfolios, { controller: 'portfolios', action: 'index' }, caption: 'Portfolio'
end
