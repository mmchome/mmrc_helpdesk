module ApplicationHelper
  def sortable(column, title = nil)
    title ||= column.titleize
    #css_class = column == sort_column ? "current #{sort_direction}" : nil //for up down arrow
    direction = column == sort_column && sort_direction == "asc"? "desc" : "asc"
    link_to title,params.merge(:sort => column, :direction => direction, :page => nil)
  end

  def issue_type_badge(title= nil)
  	case title
  	when "Critical"
  		return "-important"
  	when "High"
  		return "-warning"
  	when "Medium"
  		return "-success"
  	when "Low"
  		return '-info'
  	else
  		return ''
  	end
  end

  def row_color ticket_state_name, assigned_to, updated_at, created_at
  	#state is closed or cancelled
  	if ticket_state_name == "Closed" || ticket_state_name =="Cancelled"
  		return "inactive"
  	#open and unassigned
  	elsif ticket_state_name == "Open" && assigned_to==nil && created_at< (Time.now - 2.days)
  		return "warning"
  	elsif ticket_state_name == "Open" && assigned_to==nil && created_at>= (Time.now - 2.days)
  		return "info"
  	#open and not touched for a week
  	elsif ticket_state_name == "Open" && updated_at< (Time.now - 7.days)
  		return "error"
  	else
  		return "" 
  	end
  end

end
