class UsersController < ApplicationController
  before_action :set_user, only: %i[ show liked feed followers following discover ]
  before_action :ensure_current_user_only_sees_their_feed, only: %i[ feed discover ]

  private

    def set_user
      if params[:username]
        @user = User.find_by!(username: params.fetch(:username))
      else
        @user = current_user
      end
    end

    def ensure_current_user_only_sees_their_feed
      if current_user.username != @user.username
        redirect_back fallback_location: root_url, alert: "Redirected to your own feed."
      end
    end
end