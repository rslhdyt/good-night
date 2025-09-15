module Api
  module V1
    class MesController < ApplicationController
      before_action :authenticate_user!
      
      def show
        render json: current_user
      end

      # TODO: optimize this query by using joins
      def following_sleeps
        following = current_user.followings.pluck(:followed_id)

        sleeps = Rails.cache.fetch(
            ["following_sleeps", following.count],
            expires_in: 1.hour
          ) do
            Sleep.where(user_id: following)
              .includes(:user)
              .completed
              .previous_week
              .sorted_by_duration
              .limit(10)
              .to_a
          end

        render json: sleeps, include: { user: { only: :name } }
      end
    end
  end
end
