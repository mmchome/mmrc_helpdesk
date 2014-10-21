class UserMailer < ActionMailer::Base
  default from: "mirimchome@gmail.com"

  def welcome_email(user)
    @user=user
    @url=root_url+"/signin"
    mail to: @user.email, subject: "Welcome to MMRC ticketing system"
  end

  def ticket_assigned(previous_assignee, ticket)
    @msg_subject = "MMRC-IT: Ticket #{ticket.id} has been (re)assigned"
    @url=root_url+"/tickets/#{ticket.id}"
    
    @ticket=ticket
    @assignee= @ticket.assigned_to_user
    @owner=@ticket.reported_by_user 
    @previous_assignee = previous_assignee
    @recipients= Array.new
    if @assignee!=nil
      @recipients.push(@assignee.email)
    end
    
    if @previous_assignee !=nil 
       @recipients.push(@previous_assignee.email)
    end
    if @owner !=nil
      @recipients.push(@owner.email)
    end
    mail to: @recipients, subject: @msg_subject 
  end

  def ticket_closed (owner, assignee, ticket)
    @mgs_subject = "MMRC-IT: Your ticket #{ticket.id} has been closed"
    @url=root_url+"/tickets/#{ticket.id}"
    @owner = owner
    @assignee = assignee
    @ticket= ticket
    @recipients= Array.new
    if @assignee!=nil
      @recipients.push(@assignee.email)
    end
    if @owner !=nil
      @recipients.push(@owner.email)
    end

    mail to: @recipients, subject: @mgs_subject
  end

  def ticket_opened (owner, assignee, ticket)
    @mgs_subject = "MMRC-IT: Ticket #{ticket.id} has been opened"
    @url=root_url+"/tickets/#{ticket.id}"
    @owner = owner
    @assignee = assignee
    @ticket= ticket
    @recipients= Array.new
    if 
      @assignee!=nil
      @recipients.push(@assignee.email)
    end
    if @owner !=nil
      @recipients.push(@owner.email)
    end

    mail to: @recipients, subject: @mgs_subject
  end

end
