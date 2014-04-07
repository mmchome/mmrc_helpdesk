class NotesController < ApplicationController
	
  before_action :signed_in_user, only: [:create,:show,:new]
  
  def new
	 @note = Note.new
  end

  def create
  	@note =Note.new(note_params)
    if @note.save 
      flash[:success] = "New note added!"
      redirect_to :back
    else
      flash[:error] = "Failed to add note"
      redirect_to :back
    end
  end

  private

    def note_params
      params.require(:note).permit( :description,:updateuserid, 
        :ticket_id, :is_solution)
    end

end