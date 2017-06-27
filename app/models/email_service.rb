require 'send_grid_service'
require 'mail_gun_service'

class EmailService
  def self.send_email(email)
    # cache instences
    @mailgun ||= MailGunService.new
    @sendgrid ||= SendGridService.new

    if ENV['EMAIL_SERVICE'] == 'mailgun'
      @mailgun.send_email email
    else
      @sendgrid.send_email email
    end
  end
end
