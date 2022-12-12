class TicketsController < ApplicationController
  def new
    raise ActionController::RoutingError, "ログイン状態でに TicketsController#new アクセス"
  end

  def create
    event = Event.find(params[:event_id])
    @ticket = current_user.tickets.build do |t|
      t.event = event
      t.comment = params[:ticket][:comment]
    end
    if @ticket.save
        redirect_to event, notice: "You are going to take part in this event."
    end
  end
end
