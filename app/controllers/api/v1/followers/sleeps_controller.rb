module Api
  module V1
    module Followers
      class SleepsController < ApplicationController
        before_action :authenticate_user!

        def index
          User.find(params[:follower_id])

          sleeps = Sleep.joins("INNER JOIN follows ON follows.followed_id = sleeps.user_id")
            .where(follows: { follower_id: params[:follower_id] })
            .includes(:user)
            .completed
            .previous_week
            .sorted_by_duration
            .limit(10)

          render json: sleeps, include: { user: { only: :name } }
        end
      end
    end
  end
end