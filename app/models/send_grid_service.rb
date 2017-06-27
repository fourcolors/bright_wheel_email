require 'rest-client'

class SendGridService
  def initialize(base_url=ENV['SEND_GRID_BASE_URL'], api_key=ENV['SEND_GRID_API_KEY'])
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

    headers = {
      Authorization: "Bearer #{@api_key}",
      content_type: "application/json"
    }

    params = {
      "personalizations": [
        {
          "to": [
            {
              "email": to,
              "name": to_name 
            }
          ],
          "subject": subject
        }
      ],
      "from": {
        "email": from,
        "name": from_name
      },
      "reply_to": {
        "email": to,
        "name": to_name
      },
      "subject": subject,
      "content": [
        {
          "type": "text/plain",
          "value": body
        }
      ]
    }


    RestClient.post(@base_url, params.to_json, headers)
  end
end
