class EventTypesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update]
  before_action :authorize_owner!, only: [:edit, :update]

    def show
      @event_type = EventType.find(params[:id])
      @buffet = @event_type.buffet
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

    def deactivate
      @event_type = EventType.find(params[:id])

      if @event_type.inactive!
        redirect_to event_type_path(@event_type.id)
      else
        redirect_to event_type_path(@event_type.id), notice: 'Não foi possível desativar o tipo de evento, tente novamente mais tarde.'
      end

    end

    def activate
      @event_type = EventType.find(params[:id])

      if @event_type.active!
        redirect_to event_type_path(@event_type.id), notice: 'Tipo de evento reativado com sucesso!'
      else
        redirect_to event_type_path(@event_type.id), notice: 'Não foi possível ativar o tipo de evento, tente novamente mais tarde.'
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