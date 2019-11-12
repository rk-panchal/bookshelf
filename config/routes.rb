Rails.application.routes.draw do
	# scope module: :v1 do
	#     resources :books, only: [:index]
	#   end
  # resources :books
  root "books#index"
  resources :books do
	  collection do
	    get :searchBook
	  end
	end
   # match '/searchBook' => 'books#search', :via => [:put]
  # map.getproduct '/getBook', :controller => 'books', :action => 'search'


  # get 'books/search', to: 'books#search'
  # match '/books/search' => 'books#search',
  #             :via => :get,
  #             :constraints => { :title => /[a-z+]+/i,
  #                               :author => /[a-z+]+/i,
  #                               :description => /[0-9]+/,
  #                               :page => /[0-9]+/ }


    # resources :books do
    # 	# collection do
    # 	# 	get "search/params"
    # 	# end
    # end


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
