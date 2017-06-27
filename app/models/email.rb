class Email
  include ActiveModel::Model
  
  attr_accessor :to, :to_name, :from, :from_name, :subject, :body
  validates :to, :to_name, :from, :from_name, :subject, :body, presence: true

  def persisted?
    false
  end

  def plain_text_body
    ActionController::Base.helpers.strip_tags(self.body)
  end
end
