class TicketsController < ApplicationController
	
  before_action :signed_in_user, only: [:edit, :update,:create,:show]

  def index
  end
 
  
  def data
    tickets = Ticket.all

    render :json => {
      :total_count => tickets.length,
      :pos => 0,
      :rows => tickets.map do |ticket|
       {
          :id => ticket.id,
          :data => [ ticket.id, ticket.priority.name, ticket.issue_type.name, ticket.tittle, 
            ticket.reported_by_user.username, if ticket.assigned_to_user!= nil then  ticket.assigned_to_user.username
    else  'Unassigned' end,ticket.state.name, ticket.created_at, ticket.updated_at]
       }
          end
      }
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
     @ticket = Ticket.find(params[:id])
  end

  def update
    @ticket = Ticket.find(params[:id])
    if params[:reopen] && is_closed
      @ticket.ticket_state_id=4
    elsif(params[:save_changes] && !is_closed && user_can_edit)
       @ticket.assign_attributes(ticket_params)
    end
    if @ticket.changed?
      #if ticket close update time closed
      if(@ticket.ticket_state_id_changed? && @ticket.ticket_state_id== 5)
        #will add flash message to requie solution
        if(@ticket.notes.where("is_solution='t'").any?)
          @ticket.closed_at=Time.now
        else
          flash[:error] = "Please write solution on note section before closing ticket"
          redirect_to @ticket
          return
        end
      end
      #need to traverse changes to write human readable update message
      update_message="#{current_user.username} has changed #{@ticket.changes}"
      @sys_note = Note.create(updateuserid: 5, description: update_message, ticket_id: @ticket.id)
      if save_all(@ticket, @sys_note)
        flash[:success] = "Ticket updated"
        redirect_to @ticket
      else
        flash[:error] = "Update failed"
        redirect_to @ticket
      end
   else
      flash[:error] = "Ticket fields havent changed"
      redirect_to @ticket
   end
  end

  def show
    @ticket = Ticket.find(params[:id])
    @ticket_notes = @ticket.notes
    @note = Note.new
    @is_readonly = is_ticket_readonly
    @is_closed = is_closed
  end

  def new
    @ticket = Ticket.new
  end

  private

    def ticket_params
      params.require(:ticket).permit(:tittle, :description,:issue_type_id, 
        :ticket_state_id, :ticket_priority_id,:reported_by, :assigned_to, :is_assigned)
    end

    def admin_user
        redirect_to(root_url) unless current_user.user_types_id==1
    end

    

    def save_all(*models)
      if models.map { |rec| rec.valid? }.all?
        models.each { |rec| rec.save! }
        true
      end
    end

    def is_ticket_readonly
      if (current_user.user_types_id==3 || @ticket.ticket_state_id >4 )
        true
      else
        false
      end
    end

    def is_closed
      if ( @ticket.ticket_state_id ==5  || @ticket.ticket_state_id ==6)
        true
      else
        false
      end
    end

    def user_can_edit
      if(current_user.user_types_id==1 || current_user.user_type_id==2 || current_user.id==@ticket.reported_by)
        true
      else
        false
      end
    end
    
end
