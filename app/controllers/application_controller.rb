class ApplicationController < ActionController::API
  def create
    email = email_params

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
