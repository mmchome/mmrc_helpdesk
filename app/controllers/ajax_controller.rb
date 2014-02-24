class AjaxController < ApplicationController
  def users
    if params[:term]
      like= "%".concat(params[:term].concat("%"))
      users = User.where("username like ?", like)
    else
      users = User.all
    end
    list = users.map {|u| Hash[ id: u.id, label: u.username, name: u.username]}
    render json: list
  end
end