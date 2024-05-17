class ReviewsController < ApplicationController
    before_action :authenticate_user!, only: [:new, :create]

    def index
      @buffet = Buffet.find(params[:buffet_id])
      @reviews = @buffet.reviews
    end

    def new
        @buffet = Buffet.find(params[:buffet_id])
        @review = Review.new()
    end
  
    def create
      @buffet = Buffet.find(params[:buffet_id])
      @review = Review.new(review_params)
      @review.buffet = @buffet
      @review.user = current_user
  
      if @review.save
        redirect_to @buffet, notice: 'Avaliação criada com sucesso.'
      else
        flash.now[:alert] = 'Não foi possível cadastrar a avaliação.'
        render :new
      end
    end
  
    private
  
    def review_params
      params.require(:review).permit(:rating, :comment, photos: [])
    end
  end
  