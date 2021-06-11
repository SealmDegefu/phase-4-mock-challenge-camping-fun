class SignupsController < ApplicationController
	rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response
	rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity_response

	def create
		activity = Activity.find(params[:activity_id])
		signup = activity.signups.create!(signup_params)
		render json: signup.activity, status: :created
	  end 


	  private 

	  def render_not_found_response
		render json: { error: "Signup not found" }, status: :not_found
	  end

	  def render_unprocessable_entity_response(exception)
        render json: { errors: exception.record.errors.full_messages }, status: :unprocessable_entity
      end

	  def signup_params
		params.permit(:time, :activity_id, :camper_id)
	end 
end
