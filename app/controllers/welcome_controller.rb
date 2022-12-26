class WelcomeController < ApplicationController
  skip_before_action :authenticate

  def index
    @events = Event.where("end_at > ?", Time.zone.now).order(:start_at)
  end
end
