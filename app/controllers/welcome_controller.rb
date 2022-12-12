class WelcomeController < ApplicationController
  skip_before_action :authenticate

  def index
    @events = Event.all #wwhere("start_at > ?", Time.zone.now).order(:start_at)
  end
end
