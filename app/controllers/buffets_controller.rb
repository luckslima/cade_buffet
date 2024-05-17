class BuffetsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update]
  before_action :ensure_buffet_owner, only: [:new, :create, :edit, :update]
  before_action :authorize_owner!, only: [:edit, :update]

    def search
      @query = params[:query]
      
      @buffets = Buffet.left_joins(:event_types)
                      .where("buffets.status = 1  AND
                              buffets.brand_name LIKE :query OR 
                              buffets.city LIKE :query OR 
                              event_types.name LIKE :query", query: "%#{@query}%")
                      .distinct
                      .order(:brand_name)
    end
  
    def new
        @buffet = Buffet.new()
    end

    def create
      @buffet = Buffet.new(buffet_params)
      @buffet.user_id = current_user.id
    
      if @buffet.save
        redirect_to @buffet, notice: 'Buffet cadastrado com sucesso!'
      else
        flash.now[:alert] = 'Não foi possível cadastrar o buffet.'
        render 'new'
      end
    end
    

    def show
      @buffet = Buffet.find(params[:id])
    end

    def edit
      @buffet = Buffet.find(params[:id])
    end

    def update
      @buffet = Buffet.find(params[:id])

      if @buffet.update(buffet_params)

          redirect_to buffet_path(@buffet.id), notice: 'Buffet atualizado com sucesso!'

      else    
          flash.now[:notice] = 'Não foi possível atualizar o buffet'
          render 'edit'
      end
    end

    def deactivate
      @buffet = Buffet.find(params[:id])

      if @buffet.inactive!
        redirect_to buffet_path(@buffet.id)
      else
        redirect_to buffet_path(@buffet.id), notice: 'Não foi possível desativar o buffet, tente novamente mais tarde.'
      end

    end

    def activate
      @buffet = Buffet.find(params[:id])

      if @buffet.active!
        redirect_to buffet_path(@buffet.id), notice: 'Buffet reativado com sucesso!'
      else
        redirect_to buffet_path(@buffet.id), notice: 'Não foi possível ativar o buffet, tente novamente mais tarde.'
      end

    end

    

    private

    def buffet_params
      params.require(:buffet).permit(:brand_name, :corporate_name, :registration_number, 
                                     :phone, :email, :address, :district, :city, :state,
                                     :zip_code, :description, :payment_methods, :user_id, :image)
    end

    def ensure_buffet_owner
      unless current_user.is_buffet_owner?
        redirect_to root_path, alert: 'Você não possui um buffet.'
      end
    end

    def authorize_owner!
      @buffet = Buffet.find(params[:id])
      unless @buffet.user == current_user
        redirect_to buffet_path(@buffet), alert: 'Você não tem permissão para editar esse buffet.'
      end
    end

end