module Api
  module V1
    class CharactersController < ApplicationController
      before_action :validate_id

      def show
        # Initialize API Fetcher
        fetcher = RickyAndMorty::Fetcher.new
        character_id = params[:id]

        # Cached data? 
        result = Rails.cache.fetch("character-#{character_id}", expires_in: 1.day) do  
          # Get character data (first episode)
          character_data = fetcher.fetch_single_character(character_id)
  
          # Get episode data 
          episode_data = fetcher.fetch_episode(character_data[:first_episode])
  
          episode_data[:air_date]
        end

        render plain: result
      rescue RickyAndMorty::ApiError => e
        render json: { status: 'error', message: e.message }, status: e.status
      end

      private
  
      # If we need to validate body, is it better to use https://github.com/ruby-json-schema/json-schema
      def validate_id
        # Accept only number as id
        return if Integer(params[:id]) rescue nil?
  
        render json: { status: 'error', message: 'invalid id' }, status: :unprocessable_entity
      end
    end
  end
end