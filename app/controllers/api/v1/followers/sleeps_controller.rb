module Api
  module V1
    module Followers
      class SleepsController < ApplicationController
        before_action :authenticate_user!

        def index
          user_ids = Follow.where(follower_id: params[:follower_id]).pluck(:followed_id)

          raise ActiveRecord::RecordNotFound if user_ids.empty?

          sleeps = Rails.cache.fetch(
            ["follower_sleeps", user_ids.count],
            expires_in: 1.hour
          ) do
            Sleep.where(user_id: user_ids)
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
end

sleeps = Sleep.joins("INNER JOIN follows ON follows.followed_id = sleeps.user_id")
.where(follows: { follower_id: 1 })
.includes(:user)
.completed
.previous_week
.sorted_by_duration
.limit(10)