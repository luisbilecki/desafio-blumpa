module Api
  module V1
    class CharactersController < ApplicationController
      before_action :validate_id

      def show
        fetcher = RickyAndMorty::Fetcher.new
        character_id = params[:id]

        result = Rails.cache.fetch("character-#{character_id}", expires_in: 1.day) do  
          character_data = fetcher.fetch_single_character(character_id)  
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
        return if Integer(params[:id]) rescue nil?
  
        render json: { status: 'error', message: 'invalid id' }, status: :unprocessable_entity
      end
    end
  end
end