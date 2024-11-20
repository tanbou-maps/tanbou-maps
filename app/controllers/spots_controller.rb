class SpotsController < ApplicationController
  def search
    @google_maps_api_key = Rails.application.credentials.google_maps_api[:key]
  end
end
