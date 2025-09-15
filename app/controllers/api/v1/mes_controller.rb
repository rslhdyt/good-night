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
        sleeps = Sleep.where(
                              user_id: following
                            ).previous_week
                            .completed
                            .sorted_by_duration
                            .limit(10)

        render json: sleeps
      end
    end
  end
end
