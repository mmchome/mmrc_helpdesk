class TicketsController < ApplicationController
	
  before_action :signed_in_user, only: [:edit, :update,:create]

  def index
  end
  
  def create
  	@ticket = current_user.reported_by_tickets.build(ticket_params)
    if @ticket.save
      flash[:success] = "Ticket created!"
      redirect_to root_url
    else
      @feed_items = []
      render 'new'
    end
  end

  def edit
  end

  def show
  end

  def new
    @ticket = Ticket.new
  end

  private

    def ticket_params
      params.require(:ticket).permit(:tittle, :description,:issue_type_id, :ticket_state_id, :ticket_priority_id,:reported_by)
    end

    def admin_user
        redirect_to(root_url) unless current_user.user_types_id==1
    end
end
