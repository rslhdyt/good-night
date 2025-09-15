module Api
  module V1
    module Me
      class FollowsController < ApplicationController
        before_action :authenticate_user!

        def index
          render json: current_user.following_users
        end

        def create
          followed = current_user.followings.build(followed_id: params[:user_id])
          
          if followed.save
            render json: followed, status: :created
          else
            render json: followed.errors, status: :unprocessable_content
          end
        end

        def destroy
          current_user.followings.find_by!(followed_id: params[:id]).destroy

          render json: {
            message: "Unfollowed successfully"
          }, status: :no_content
        end
      end
    end
  end
end