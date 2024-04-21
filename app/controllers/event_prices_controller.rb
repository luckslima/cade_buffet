class EventPricesController < ApplicationController
    before_action :authenticate_user!, only: [:new, :create]
    before_action :ensure_buffet_owner, only: [:new, :create]
    before_action :authorize_owner!, only: [:edit, :update]

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

    def edit
      @event_price = EventPrice.find(params[:id])
      @event_type = EventType.find(params[:event_type_id])
    end

    def update
      @event_price = EventPrice.find(params[:id])

      if @event_price.update(event_price_params)

          redirect_to event_type_path(@event_price.event_type), notice: 'Preços atualizados com sucesso.'

      else    
          flash.now[:notice] = 'Não foi possível atualizar o preço do tipo de evento.'
          render 'edit'
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

    def authorize_owner!
      @event_type = EventType.find(params[:event_type_id])
      unless @event_type.buffet.user == current_user
        redirect_to buffet_path(@buffet), alert: 'Você não tem permissão para editar esse tipo de evento.'
      end
    end

end