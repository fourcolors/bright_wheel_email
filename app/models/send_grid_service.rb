require 'rest-client'

class SendGridService
  def initialize(base_url=ENV['SEND_GRID_BASE_URL'], api_key=ENV['SEND_GRID_API_KEY'])
    @api_key = api_key
    @base_url = base_url
  end

  def send_email(email)
    RestClient.post(@base_url, email_json(email), headers)
  end

  private

  def headers
    {
      Authorization: "Bearer #{@api_key}",
      content_type: "application/json"
    }
  end

  def email_json(email)
    {
      "personalizations": [
        {
          "to": [
            {
              "email": email.to,
              "name": email.to_name 
            }
          ],
          "subject": email.subject
        }
      ],
      "from": {
        "email": email.from,
        "name": email.from_name
      },
      "reply_to": {
        "email": email.to,
        "name": email.to_name
      },
      "subject": email.subject,
      "content": [
        {
          "type": "text/plain",
          "value": email.body
        }
      ]
    }.to_json
  end
end
