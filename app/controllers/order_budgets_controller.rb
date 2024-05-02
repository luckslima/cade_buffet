class OrderBudgetsController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_buffet_owner, only: [:new, :create]
  before_action :authorize_owner!, only: [:new, :create]

    def new
        @order = Order.find(params[:order_id])  
        @order_budget = OrderBudget.new()
        @base_price = @order.event_type.calculate_base_price(@order.event_date, @order.number_of_guests)
    end

    def create
        @order = Order.find(params[:order_id])
        order_budget_params = params.require(:order_budget).permit(:valid_until, :payment_method, :extra_fee, :discount, :description)
        
        extra_fee = order_budget_params[:extra_fee].present? ? order_budget_params[:extra_fee].gsub(',', '.').to_f : 0.0
        discount = order_budget_params[:discount].present? ? order_budget_params[:discount].gsub(',', '.').to_f : 0.0
    
        @order_budget = OrderBudget.new(order_budget_params.except(:extra_fee, :discount))
        @order_budget.extra_fee = extra_fee
        @order_budget.discount = discount
        @order_budget.user = @order.user
        @order_budget.buffet = current_user.buffet
        @order_budget.order = @order
    
        base_price = @order.event_type.calculate_base_price(@order.event_date, @order.number_of_guests)
        @order_budget.final_price = base_price + extra_fee - discount
    
        if @order_budget.save
          @order.approved!
          redirect_to order_path(@order), notice: 'Orçamento registrado com sucesso, pedido aprovado!'
        else
          flash.now[:notice] = 'Não foi possível aprovar o pedido.'
          render :new
        end
      end

      private

      def ensure_buffet_owner
        unless current_user.is_buffet_owner?
          redirect_to root_path, alert: 'Você não possui um buffet.'
        end
      end
  
      def authorize_owner!
        @order = Order.find(params[:order_id])
        unless @order.buffet.user == current_user
          redirect_to root_path, alert: 'Você não tem permissão para gerar esse orçamento.'
        end
      end

end