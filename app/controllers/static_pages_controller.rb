class StaticPagesController < ApplicationController
  def home
  	@ticket = current_user.assigned_to_tickets.build if signed_in?
  	@feed_items = current_user.feed.paginate(page: params[:page])
  end

  def contact
  end

  def about
  end

  def faq
  end
end
