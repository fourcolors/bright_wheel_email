class EmailController < ApplicationController
  def create
    email = Email.new email_params

    if email.valid?
      # EmailService.send_email email_params
      head :no_content
    else
      render :json => { :errors => email.errors.full_messages}
    end
  end

  private

  def email_params
    params.permit(:to, :to_name, :from, :from_name, :subject, :body)
  end
end
