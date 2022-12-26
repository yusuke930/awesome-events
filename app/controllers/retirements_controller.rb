class RetirementsController < ApplicationController

    def new
    end

    def create
      current_user.destroy
      if current_user.destroy
        reset_session
        redirect_to root, notice: "You canceled the membership"
      end
    end
end
