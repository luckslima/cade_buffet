class Api::V1::EventTypesController < Api::V1::ApiController
    
    def index
        buffet = Buffet.find(params[:buffet_id])
        event_types = buffet.event_types
        render status: 200, json: event_types.as_json(except: [:created_at, :updated_at])
    end

    def availability
        buffet = Buffet.find(params[:buffet_id])
        event_type = EventType.find(params[:id])
        number_of_guests = params[:guests].to_i

        if params[:date].blank? || params[:guests].blank?
            render status: 400, json: { error: "Data e quantidade de convidados são obrigatórios." }
            return
        end

        begin
            event_date = Date.strptime(params[:date], '%d/%m/%Y')
        rescue ArgumentError
            return render status: 400, json: { error: 'Formato de data inválido' }
        end

        if number_of_guests < event_type.min_guests || number_of_guests > event_type.max_guests
            return render status: 406, json: { error: "Quantidade de convidados fora do limite permitido." }
        end

        if Order.where(buffet_id: buffet.id, event_type: event_type, event_date: event_date, status: :approved).exists?
            return render status: 406, json: { error: "Não há disponibilidade para a data escolhida." }
        end

        base_price = event_type.calculate_base_price(event_date, number_of_guests)

        render status: 200, json: { available: true, estimated_price: base_price }

    end

end