class Api::V1::BuffetsController < Api::V1::ApiController

    def index

        if params[:search].present?
            buffets = Buffet.where('brand_name LIKE ?', "%#{params[:search]}%")
        else
            buffets = Buffet.all()
        end

        render status:200, json: buffets.as_json(except: [:created_at, :updated_at])
    end

    def show

        buffet = Buffet.find(params[:id])
        render status: 200, json: buffet.as_json(except: [:corporate_name, :registration_number, :created_at, :updated_at])
        
    end

end