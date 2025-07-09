class Message
  include Mongoid::Document
  include Mongoid::Timestamps
  field :content, type: String
  field :phone_number, type: String
  field :status, type: String
  field :twilio_sid, type: String

  validates :phone_number, presence: true
  belongs_to :user
end
