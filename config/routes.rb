Rails.application.routes.draw do

  namespace :public do
    get 'relationships/followings'
    get 'relationships/followers'
  end
    get 'relationships/followings'
    get 'relationships/followers'
  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
  sessions: "admin/sessions"
  }

  devise_for :customers,skip: [:passwords], controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
  }

  namespace :admin do

    root to: 'homes#top'
    resources :photos, only: [:show, :destroy]
    resources :customers, only: [:index, :show, :edit, :update, :destroy]
    resources :reports, only: [:index]

  end

  #public内にデータはあるが、URLにpublicを表示させないようにする
  scope module: :public do

    root to:  'homes#top'
    # get URL => "コントローラ名#アクション名"
    get "/about" => "homes#about", as:"about"
    get "/guidance" => "homes#guidance", as:"guidance"

    resources :photos do
    get "/photos/type_search" => "photos#type_search"
      resource :favorites, only: [:create, :destroy]
      collection do
       get "favorite" => "favorites#index"
      end
    end

    resources :customers, only: [:show, :edit, :update] do
      resource :relationships, only: [:create, :destroy]
      collection do
        get "relationships" => "relationships#index"
      end
      member do
        get 'followings'
        get 'followers'
      end
    end

    #退会確認画面
    get '/customers/unsubscribe' => 'customers#unsubscribe' , as: 'unsubscribe'
    # 論理削除用のルーティング
    patch '/customers/withdraw' => 'customers#withdraw', as: 'withdraw'



    resources :photos do
      resources :comments, only: [:new, :create, :destroy]
    end


    resources :reports, only: [:index]

  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
