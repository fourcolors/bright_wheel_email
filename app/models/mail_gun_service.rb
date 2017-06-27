require 'rest-client'

class MailGunService
  def initialize(base_url=ENV['MAIL_GUN_BASE_URL'], api_key=ENV['MAIL_GUN_API_KEY'])
    @api_key = api_key
    @base_url = base_url
  end

  def send_email(email)
    RestClient::Request.execute(
      :user => "api",
      :password => @api_key,
      :url => "#{@base_url}/messages",
      :method => :post,
      :payload => {
        :from => email.from,
        :sender => email.from_name,
        :to => email.to,
        :subject => email.subject,
        :text => email.body,
        :multipart => true
      },
      :headers => {
        :"h:X-My-Header" => "www/mailgun-email-send"
      },
      :verify_ssl => false
    )
  end
end
