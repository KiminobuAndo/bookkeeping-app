class DashboardController < ApplicationController
  layout "dashboard"

  def index
    @courses = Course.published.order(:created_at)
  end
end
