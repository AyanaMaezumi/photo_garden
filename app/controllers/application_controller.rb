class ApplicationController < ActionController::Base

  before_action :authentication!, except: [:top, :about, :guidance]
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  #customerでサインインした時と、adminがサインインした時は、そのまま、ページに飛ぶ。
  def authentication!
    if customer_signed_in?
      return true
    elsif admin_signed_in?
      return true
    else
  #ログインしていない場合は、下記で記したURLへ飛ぶことは許可する。request.fullpath=>URL。＝＝等しい。｜｜又は。
      if request.fullpath == '/customers/sign_in' ||
        request.fullpath == '/customers/sign_up' ||
        request.fullpath == '/photos' ||
        request.fullpath == '/admin/sign_in'
        return true
      end
  #ログインしていなくても、新規登録を許可する。
      if (params[:controller] == "public/registrations") && (params[:action] == "create")
        return true
      end
  #それ以外は、クリックしてもTOPページにリダイレクトする。
      redirect_to root_path
    end
  end

  def after_sign_in_path_for(resource)
    if resource.is_a?(Admin)
      root_path
    else
      customer_path(resource)
    end
  end


  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:nickname, :image])
  end

end
