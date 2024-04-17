class BuffetsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]
  before_action :ensure_buffet_owner, only: [:new, :create]

    def new
        @buffet = Buffet.new()
    end

    def create
        @buffet = Buffet.new(buffet_params)
        @buffet.user = current_user

        if @buffet.save 
          redirect_to @buffet, notice: 'Buffet cadastrado com sucesso!'
        else 
          flash.now[:notice] = 'Não foi possível cadastrar o buffet.'
          render 'new' 
        end
    end

    def show
      @buffet = Buffet.find(params[:id])
    end

    private

    def buffet_params
      params.require(:buffet).permit(:brand_name, :corporate_name, :registration_number, 
                                     :phone, :email, :address, :district, :city, :state,
                                     :zip_code, :description, :payment_methods)
    end

    def ensure_buffet_owner
      unless current_user.is_buffet_owner?
        redirect_to root_path, alert: 'Você não possui um buffet.'
      end
    end

end