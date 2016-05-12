# == Route Map
#
#                             Prefix Verb   URI Pattern                                   Controller#Action
#                         admin_root GET    /admin(.:format)                              admin/dashboard#index
#        batch_action_admin_articles POST   /admin/articles/batch_action(.:format)        admin/articles#batch_action
#                     admin_articles GET    /admin/articles(.:format)                     admin/articles#index
#                                    POST   /admin/articles(.:format)                     admin/articles#create
#                  new_admin_article GET    /admin/articles/new(.:format)                 admin/articles#new
#                 edit_admin_article GET    /admin/articles/:id/edit(.:format)            admin/articles#edit
#                      admin_article GET    /admin/articles/:id(.:format)                 admin/articles#show
#                                    PATCH  /admin/articles/:id(.:format)                 admin/articles#update
#                                    PUT    /admin/articles/:id(.:format)                 admin/articles#update
#                                    DELETE /admin/articles/:id(.:format)                 admin/articles#destroy
#                    admin_dashboard GET    /admin/dashboard(.:format)                    admin/dashboard#index
#      batch_action_admin_news_index POST   /admin/news/batch_action(.:format)            admin/news#batch_action
#                   admin_news_index GET    /admin/news(.:format)                         admin/news#index
#                                    POST   /admin/news(.:format)                         admin/news#create
#                     new_admin_news GET    /admin/news/new(.:format)                     admin/news#new
#                    edit_admin_news GET    /admin/news/:id/edit(.:format)                admin/news#edit
#                         admin_news GET    /admin/news/:id(.:format)                     admin/news#show
#                                    PATCH  /admin/news/:id(.:format)                     admin/news#update
#                                    PUT    /admin/news/:id(.:format)                     admin/news#update
#                                    DELETE /admin/news/:id(.:format)                     admin/news#destroy
# batch_action_admin_news_sourceurls POST   /admin/news_sourceurls/batch_action(.:format) admin/news_sourceurls#batch_action
#              admin_news_sourceurls GET    /admin/news_sourceurls(.:format)              admin/news_sourceurls#index
#                                    POST   /admin/news_sourceurls(.:format)              admin/news_sourceurls#create
#           new_admin_news_sourceurl GET    /admin/news_sourceurls/new(.:format)          admin/news_sourceurls#new
#          edit_admin_news_sourceurl GET    /admin/news_sourceurls/:id/edit(.:format)     admin/news_sourceurls#edit
#               admin_news_sourceurl GET    /admin/news_sourceurls/:id(.:format)          admin/news_sourceurls#show
#                                    PATCH  /admin/news_sourceurls/:id(.:format)          admin/news_sourceurls#update
#                                    PUT    /admin/news_sourceurls/:id(.:format)          admin/news_sourceurls#update
#                                    DELETE /admin/news_sourceurls/:id(.:format)          admin/news_sourceurls#destroy
#                     admin_comments GET    /admin/comments(.:format)                     admin/comments#index
#                                    POST   /admin/comments(.:format)                     admin/comments#create
#                      admin_comment GET    /admin/comments/:id(.:format)                 admin/comments#show
#        admin_import_news_sourceurl POST   /admin/news_sourceurls/:id/import(.:format)   admin/news_sourceurls#import_news
#                               root GET    /                                             articles#index
#                           articles GET    /articles(.:format)                           articles#index
#                                    POST   /articles(.:format)                           articles#create
#                            article GET    /articles/:id(.:format)                       articles#show
#                                    PATCH  /articles/:id(.:format)                       articles#update
#                                    PUT    /articles/:id(.:format)                       articles#update
#                                    DELETE /articles/:id(.:format)                       articles#destroy
#                            picture GET    /picture(.:format)                            home#picture
#                             weekly GET    /weekly(.:format)                             home#weekly
#                      message_board GET    /message_board(.:format)                      message_board#index
#                             signin GET    /signin(.:format)                             sessions#signin
#                              login POST   /login(.:format)                              sessions#create
#                             logout DELETE /logout(.:format)                             sessions#destroy
#

Rails.application.routes.draw do
  ActiveAdmin.routes(self)

  namespace :admin do
    post "news_sourceurls/:id/import", to: 'news_sourceurls#import_news', as: "import_news_sourceurl"
  end

  root 'articles#index'
  resources :articles, except: [:new, :edit]
  get '/picture', to: 'home#picture'
  # get '/hackathon', to: 'home#hackathon'
  get '/weekly', to: 'home#weekly'
  get '/message_board', to: 'message_board#index'
  
  get '/signin', to: 'sessions#signin'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
end
