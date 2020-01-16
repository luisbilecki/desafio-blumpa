module Api
  module V1
    class CharactersController < ApplicationController
      def show
        fetcher = RickyAndMorty::Fetcher.new

        # Get character data (first episode)
        character_id = params[:id]
        character_data = fetcher.fetch_single_character(character_id)

        # Get episode data 
        episode_data = fetcher.fetch_episode(character_data[:first_episode])

        render json: { status: 'success', air_date: episode_data[:air_date] }
      end
    end
  end
end