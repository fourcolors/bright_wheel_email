require 'send_grid_service'
require 'mail_gun_service'

class EmailService
  def self.send_email(email)
    # cache instences
    @@mailgun ||= MailGunService.new
    @@sendgrid ||= SendGridService.new

    if ENV['EMAIL_SERVICE'] == 'mailgun'
      @@dominant_provider = @@mailgun
      @@backup_provider = @@sendgrid
    else
      @@dominant_provider = @@sendgrid
      @@backup_provider = @@mailgun
    end

    # try first provider, if it fails, attempted the second provider
    begin
      @@dominant_provider.send_email email
    rescue
      @@backup_provider.send_email email
    end
  end
end
