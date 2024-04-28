class EventTypesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update]
  before_action :authorize_owner!, only: [:edit, :update]

    def show
      @event_type = EventType.find(params[:id])
    end

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

    def edit
      @event_type = EventType.find(params[:id])
    end

    def update
      @event_type = EventType.find(params[:id])

      if @event_type.update(event_type_params)

          redirect_to event_type_path(@event_type), notice: 'Tipo de evento atualizado com sucesso!'

      else    
          flash.now[:notice] = 'Não foi possível atualizar o tipo de evento.'
          render 'edit'
      end
    end

    private

    def event_type_params
        params.require(:event_type).permit(:name, :description, :min_guests, :max_guests, :menu_description, :alcohol_included, :decoration_included, :parking_available, :location_type, :duration_minutes, :image)
    end

    def authorize_owner!
      @event_type = EventType.find(params[:id])
      unless @event_type.buffet.user == current_user
        redirect_to buffet_path(@buffet), alert: 'Você não tem permissão para editar esse tipo de evento.'
      end
    end

end