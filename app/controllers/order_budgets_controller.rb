class OrderBudgetsController < ApplicationController

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

end