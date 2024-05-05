class OrdersController < ApplicationController
    before_action :authenticate_user!
    before_action :ensure_client, only: [:new, :create]

    def new
        @order = Order.new()
        @event_type = EventType.find(params[:event_type_id])
    end

    def create
        @event_type = EventType.find(params[:event_type_id])
        @order = Order.new(order_params)
        @order.user = current_user
        @order.buffet = @event_type.buffet
        @order.event_type = @event_type

        if @order.save!
            redirect_to @order, notice: 'Pedido criado com sucesso, aguarde a aprovaçao do Buffet!'
        else
            flash.now[:notice] = 'Não foi possível criar pedido.'
            render :new
        end
    end

    def show
        @order = Order.find(params[:id])
        authorize @order

        if current_user.is_buffet_owner
            @orders_same_day = Order.where(buffet_id: @order.buffet_id, event_date: @order.event_date)
                                          .where.not(id: @order.id)
        end
    end

    def index
        if current_user.is_buffet_owner
          @pending_orders = Order.joins(:buffet)
                                 .where(buffets: { user_id: current_user.id }, status: :pending)
                                 .order(event_date: :asc)
          @other_orders = Order.joins(:buffet)
                                .where(buffets: { user_id: current_user.id })
                                .where.not(status: :pending)
                                .order(event_date: :asc)
        else
          @orders = current_user.orders.order(event_date: :asc)
        end
    end

    def confirmed
        @order = Order.find(params[:id])
    
        if Date.today <= @order.order_budget.valid_until
            @order.confirmed!
            redirect_to order_path(@order), notice: 'Pedido confirmado com sucesso!'
        else
            redirect_to order_path(@order), alert: 'O prazo para confirmação deste pedido expirou.'
        end

    end    


    private

    def order_params
        params.require(:order).permit(:number_of_guests, :event_date, :address, :details, :payment_method_id)
    end

    def authorize(order)
        redirect_to root_path, alert: 'Acesso negado!' unless order.user == current_user || order.buffet.user == current_user
    end

    def ensure_client
        if  current_user.is_buffet_owner?
            redirect_to root_path, alert: 'Acesso negado, você não é um cliente!'
        end
    end

end