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

  def destroy
    @ticket = current_user.tickets.find_by!(event_id: params[:event_id])
    @ticket.destroy!
    redirect_to event_path(params[:event_id]), notice: "Participation for this event is canceled"
  end
end
