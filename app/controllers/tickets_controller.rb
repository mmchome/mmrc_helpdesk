class TicketsController < ApplicationController

  helper_method :sort_column, :sort_direction
	
  before_action :signed_in_user, only: [:edit, :update,:create,:show, :new, :index]


  def index
    @tickets = Ticket.search(params[:search]) .order(sort_column + " " + sort_direction).paginate(:per_page => 15, :page => params[:page])
      # @search = Ticket.search do
      #   fulltext params[:search]
      #   order_by(sort_column,sort_direction)
      # end
      # @tickets = @search.results
      #.paginate(:per_page => 5, :page => params[:page])    
  end 

  def create
  	@ticket = current_user.reported_by_tickets.build(ticket_params)
    if @ticket.save 
      flash[:success] = "Ticket created!"
      redirect_to root_url
      UserMailer.ticket_opened(@ticket.reported_by_user, @ticket.assigned_to_user,@ticket).deliver
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
    @is_reassigned= false
    @is_opened= false
    @previous_assignee=nil
    if params[:reopen] && is_closed
      @ticket.ticket_state_id=1
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
          flash[:error] = "Please write solution on the notes section before closing the ticket"
          redirect_to @ticket
          return
        end
      end
      #need to traverse changes to write human readable update message
      update_message="#{current_user.username} has made the following changes:"
      #{}{@ticket.changes}"
      @ticket.changes.each do |key, value|
        update_message+= "\n"
        if(key=="reported_by")
          update_message+="Ticket Reporter from: #{User.find(value[0]).username} to #{User.find(value[1]).username}"
        elsif(key=="ticket_priority_id")
          update_message+="Ticket Priority from: #{TicketPriority.find(value[0]).name} to #{TicketPriority.find(value[1]).name}"
        elsif(key=="ticket_state_id")
          #ticket is currently closed and will be marked as open
          if(is_closed & value[1]==1)
            @is_opened= true
          end
          update_message+="Ticket State from: #{TicketState.find(value[0]).name} to #{TicketState.find(value[1]).name}"
        elsif(key=="issue_type_id")
          update_message+="TicketType from: #{IssueType.find(value[0]).name} to #{IssueType.find(value[1]).name}"
        elsif(key=="assigned_to")
          update_message+="Assigned Technician from: "
           @is_reassigned=true;
           if value[0]!=nil 
             @previous_assignee=User.find(value[0])
             update_message+="#{@previous_assignee.username}" 
           else
            update_message+=" none "
           end
           if value[1] !=nil
              update_message+=" to #{User.find(value[1]).username}"
           else
              update_message+=" to none"
           end
        elsif(key=="title")
          update_message+="Ticket title"
        elsif(key=="description")
          update_message+="Ticket description"
        else
          update_message+=key
        end
      end
      @sys_note = Note.create(updateuserid: 1, description: update_message, ticket_id: @ticket.id)
      if save_all(@ticket, @sys_note)
        if(is_closed)
          UserMailer.ticket_closed(@ticket.reported_by_user, @ticket.assigned_to_user,@ticket).deliver
        elsif (@is_opened)
          UserMailer.ticket_opened(@ticket.reported_by_user, @ticket.assigned_to_user,@ticket).deliver
        end
        if(@is_reassigned)
          UserMailer.ticket_assigned(@previous_assignee,@ticket).deliver
        end
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
    @ticket_notes_user = @ticket_notes.where.not(updateuserid: '1')
    @ticket_notes_system=  @ticket_notes.where(updateuserid: '1')
    @note = Note.new
    @is_readonly = is_ticket_readonly
    @is_closed = is_closed
  end

  def new
    @ticket = Ticket.new
  end

  private
    def create_update_msg
    end

    def ticket_params
      params.require(:ticket).permit(:title, :description,:issue_type_id, 
        :ticket_state_id, :ticket_priority_id,:reported_by, :assigned_to, :is_assigned)
    end

    def admin_user
        redirect_to(root_url) unless current_user.user_types_id==1
    end


    def sort_column
      Ticket.column_names.include?(params[:sort]) ? params[:sort] : "id"
    end
  
    def sort_direction
     %W[asc ,desc].include?(params[:direction]) ? params[:direction] : "desc"
    end    

    def save_all(*models)
      if models.map { |rec| rec.valid? }.all?
        models.each { |rec| rec.save! }
        true
      end
    end

    def sys_note_message()

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
      if(current_user.user_types_id==1 || current_user.user_types_id==2 || current_user.id==@ticket.reported_by)
        true
      else
        false
      end
    end
    
end
