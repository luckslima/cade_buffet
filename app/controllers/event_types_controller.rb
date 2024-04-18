class EventTypesController < ApplicationController

    def new
      @event_type = EventType.new()
    end

    def create
        @event_type = EventType.new(event_type_params)
        @event_type.buffet = current_user.buffet


        if @event_type.save
            redirect_to buffet_path(@event_type.buffet), notice: 'Tipo de evento foi criado com sucesso.'
          else
            flash.now[:notice] = 'Não foi possível criar o tipo de evento.'
            render :new
          end

    end

    private

    def event_type_params
        params.require(:event_type).permit(:name, :description, :min_guests, :max_guests, :menu_description, :alcohol_included, :decoration_included, :parking_available, :location_type, :duration_minutes)
    end

end