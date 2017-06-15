class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  # Хелпер метод, доступный во вьюхах
  helper_method :current_user_can_edit?

  before_action :configure_permitted_parameters, if: :devise_controller?

  # Настройка для девайза — разрешаем обновлять профиль, но обрезаем
  # параметры, связанные со сменой пароля.

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(
      :account_update, keys: [:password, :password_confirmation, :current_password]
    )
  end

  def current_user_can_edit?(event)
    user_signed_in? && event.user == current_user
  end
end
