class Advertisement
  include Mongoid::Document
  include Mongoid::Timestamps
  include GlobalID::Identification
  include AdvertisementRepresentations

  #
  ## CONSTANTS
  #
  TYPES = %i[sell buy].freeze

  #
  ## FIELDS
  #
  field :ad_type, type: Symbol
  field :title, type: String
  field :location, type: String
  field :description, type: String
  field :price, type: Float
  field :author_name, type: String
  field :author_email, type: String
  field :author_phone, type: String
  field :terms_of_service, type: Boolean
  field :admin_token, type: String

  #
  ## VALIDATIONS
  #
  with_options presence: true do
    validates :ad_type, inclusion: {in: TYPES}
    validates :title, length: {minimum: 2, maximum: 100}
    validates :description, length: {minimum: 2, maximum: 3000}
    validates :price, numericality: {greater_than: 0}
    validates :author_name, length: {minimum: 2, maximum: 100}
    validates :author_email, confirmation: true
    validates :author_phone, phone: true
  end

  validates :location, length: {minimum: 2, maximum: 100, allow_blank: true}
  validates :terms_of_service, acceptance: true
  validate :validate_author_email

  #
  ## CALLBACKS
  #
  before_create :generate_admin_token
  after_create :send_email

  #
  ## PRIVATE METHODS
  #
  private

  def validate_author_email
    errors.add(:author_email, :invalid) unless EmailAddress.valid?(author_email)
  end

  def generate_admin_token
    self.admin_token = SecureRandom.hex(13)
  end

  def send_email
    AdvertisementMailer.with(advertisement: self).created_email.deliver_later
  end
end
