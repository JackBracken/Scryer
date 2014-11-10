class FeedbackController < ApplicationController
  def create
    @feedback = Feedback.new(feedback_params)

    if current_user
      @feedback.user = current_user
    end

    respond_to do |format|
      if @feedback.save
        format.html { redirect_to @feedback, notice: 'Feedback was successfully recorded. Thank you for your input!' }
        format.js { render action: 'create' }
        format.json { render json: @feedback, status: :created, location: @feedback }
      end
    end
  end

  private
      # Never trust parameters from the scary internet, only allow the white list through.
    def feedback_params
      params.require(:feedback).permit(:feedback_text, :score)
    end
end
