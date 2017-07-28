Rails.application.routes.draw do
  root 'statistics#index'

  get '/api/v1/statistics'  => 'statistics#index_with_sort'

end
