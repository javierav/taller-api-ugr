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
    validates :title, length: {minimum: 2, maximum: 30}
    validates :location, length: {minimum: 2, maximum: 30, allow_blank: true}
    validates :description, length: {minimum: 2, maximum: 30}
    validates :price, numericality: {greater_than: 0}
    validates :author_name, length: {minimum: 2, maximum: 30}
    validates :author_email, confirmation: true
    validates :author_phone, phone: true
    validates :admin_token
  end

  validates :terms_of_service, acceptance: true
  validate :validate_author_email

  #
  ## CALLBACKS
  #
  before_save :generate_admin_token

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
end
