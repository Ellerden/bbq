class SubscriptionsController < ApplicationController
  before_action :set_event, only: [:create, :destroy]
  before_action :set_subscription, only: [:destroy]
  before_action :verify_email, :unless => :signed_in?

  # POST /subscriptions
  def create
    unless own_subscription

      # Болванка для новой подписки
      @new_subscription = @event.subscriptions.build(subscription_params)
      @new_subscription.user = current_user

      if @new_subscription.save
        EventMailer.subscription(@event, @new_subscription).deliver_now
        # Если сохранилась успешно, редирект на страницу самого события
        redirect_to @event, notice: I18n.t('controllers.subscriptions.created')
      else
        # если ошибки — рендерим здесь же шаблон события
        render 'events/show', alert: I18n.t('controllers.subscriptions.error')
      end

    end
  end
  def destroy
    message = {notice: I18n.t('controllers.subscriptions.destroyed')}

    if current_user_can_edit?(@subscription)
      @subscription.destroy
    else
      message = {alert: I18n.t('controllers.subscriptions.error')}
    end

    redirect_to @event, message
  end


  private

    def set_subscription
      @subscription = @event.subscriptions.find(params[:id])
    end

    def set_event
      @event = Event.find(params[:event_id])
    end

    def subscription_params
      # .fetch разрешает в params отсутствие ключа :subscription
      params.fetch(:subscription, {}).permit(:user_email, :user_name)
    end

    def verify_email
      mail = params[:user_email]
      registred_email = User.find_by_email(params[:user_email])
      if registred_email.nil?
      redirect_to @event, alert: I18n.t('controllers.subscriptions.registred_user')
      end
    end

    def own_subscription
      if (@event.user == current_user)
        redirect_to @event, alert: I18n.t('controllers.subscriptions.own')
      end
    end
end
