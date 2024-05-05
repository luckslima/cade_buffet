class MessagesController < ApplicationController
    def create
        @order = Order.find(params[:order_id])
        @message = Message.new(message_params)
        @message.user = current_user
        @message.order = @order
      
        if @message.save
          redirect_to order_path(@order), notice: "Mensagem enviada com sucesso."
        else
          redirect_to order_path(@order), alert: "Não foi possível enviar a mensagem."
        end
      end
      
      private
      
      def message_params
        params.require(:message).permit(:content)
      end
end