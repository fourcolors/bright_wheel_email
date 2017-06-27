class EmailController < ApplicationController
  def create
    EmailService.send_email email_params
    head :no_content
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
