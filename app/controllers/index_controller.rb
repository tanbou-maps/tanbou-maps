class IndexController < ApplicationController
  before_action :require_sign_in

  def show
    @latest_spots = Spot.order(created_at: :desc).limit(4).map do |spot|
      {
        id: spot.id,
        name: spot.name,
        description: spot.description,
        images: spot.images.map { |image| url_for(image) }
      }
    end
  end
end
