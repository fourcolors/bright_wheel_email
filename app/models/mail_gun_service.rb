require 'rest-client'

class MailGunService
  def initialize(base_url=ENV['MAIL_GUN_BASE_URL'], api_key=ENV['MAIL_GUN_API_KEY'])
    @api_key = api_key
    @base_url = base_url
  end

  def send_email(email_params)
    to = email_params[:to]
    to_name = email_params[:to_name]
    from = email_params[:from]
    from_name = email_params[:from_name]
    subject = email_params[:subject]
    body = email_params[:body]

    RestClient::Request.execute(
      :user => "api",
      :password => @api_key,
      :url => "#{@base_url}/messages",
      :method => :post,
      :payload => {
        :from => from,
        :sender => from_name,
        :to => to,
        :subject => subject,
        :text => body,
        :multipart => true
      },
      :headers => {
        :"h:X-My-Header" => "www/mailgun-email-send"
      },
      :verify_ssl => false
    )
  end
end
