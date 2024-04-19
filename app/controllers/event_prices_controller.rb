class EventPricesController < ApplicationController
    before_action :authenticate_user!, only: [:new, :create]
    before_action :ensure_buffet_owner, only: [:new, :create]

    def new
        @event_price = EventPrice.new()
        @event_type = EventType.find(params[:event_type_id])
    end

    def create
        @event_price = EventPrice.new(event_price_params)
        @event_price.event_type = EventType.find(params[:event_type_id])

        if @event_price.save
            redirect_to event_type_path(@event_price.event_type), notice: 'Preços registrados com sucesso.'
          else
            flash.now[:notice] = 'Não foi possível registrar o preço.'
            render :new
          end
    end

    private

    def event_price_params
        params.require(:event_price).permit(:base_price, :additional_guest_price, :extra_hour_price, :price_for_weekend)
    end

    def ensure_buffet_owner
        unless current_user.is_buffet_owner?
          redirect_to root_path, alert: 'Você não possui um buffet.'
        end
    end

end