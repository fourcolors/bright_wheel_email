class EmailController < ApplicationController
  def create
    EmailService.send_email email_params

    # if email_response
      # head :no_content
    # else
      # render :unprocessable_entity
    # end
  end

  private

  def email_params
    params.tap do |email_params|
      email_params.require(:to)
      email_params.require(:to_name)
      email_params.require(:from)
      email_params.require(:from_name)
      email_params.require(:subject)
      email_params.require(:body)
    end
  end
end
