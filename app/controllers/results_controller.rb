class ResultsController < ApplicationController
  layout "dashboard"

  def show
    @result = Result.includes(result_details: :question).find(params[:id])
    unless @result.user == current_user
      redirect_to dashboard_path, alert: "アクセスできません"
    end
  end
end
