module Api
  module V1
    module Me
      class SleepsController < ApplicationController
        before_action :authenticate_user!

        def index
          render json: current_user.sleeps
        end

        def create
          if current_user.sleeps.has_active_session.exists?
            render json: { error: "You already have an active sleep session" }, status: :unprocessable_content
            return
          end

          sleep = current_user.sleeps.build(sleep_start: Time.now)

          if sleep.save
            render json: sleep, status: :created
          else
            render json: sleep.errors, status: :unprocessable_content
          end
        end

        def update
          sleep = current_user.sleeps.find(params[:id])

          if sleep.sleep_end.present?
            render json: { error: "Sleep already ended" }, status: :unprocessable_content
            return
          end

          if update_sleep(sleep)
            render json: sleep, status: :ok
          else
            render json: sleep.errors, status: :unprocessable_content
          end
        end

        private

        def update_sleep(sleep)
          sleep.update(
            sleep_end: Time.now, 
            duration: Time.now - sleep.sleep_start
          )
        end
      end
    end
  end
end