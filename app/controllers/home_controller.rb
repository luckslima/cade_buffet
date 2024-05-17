class HomeController < ApplicationController
    def index
        @buffets = Buffet.where(status: 1).order(:brand_name)
    end
end