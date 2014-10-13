class User < ActiveRecord::Base
  extend FriendlyId

  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable
  attr_accessor :stripe_token

  extend ActiveHash::Associations::ActiveRecordExtensions

  before_validation :generate_slug
  before_validation :set_defaults
  before_save :update_stripe

  friendly_id :slug, use: [:slugged, :finders]

  # Associations
  belongs_to_active_hash :role
  belongs_to_active_hash :plan

  has_many :posts
  has_many :comments


  # Validations
  validates :name, presence: true
  validates :role, inclusion: { in: Role.all }
  validates :slug, presence: true
  validates :website, url: { allow_blank: true, allow_nil: true}

  # Delegations
  delegate :admin?, to: :role
  delegate :member?, to: :role

  # Scopes
  scope :members, -> { where(role_id: 0) }

  # Instance Methods

  # def name
  #   [first_name, last_name].join(' ')
  # end

  def update_stripe
    return if email.include?('@ttimsmith.com')
    return if email.include?('@example.com') and not Rails.env.production?
    if customer_id.nil?
      if !stripe_token.present?
        raise "Stripe token not present. Can't create account."
      end
      customer = Stripe::Customer.create(
        :email => email,
        :description => name,
        :card => stripe_token,
        :plan => Plan.find(plan_id).stripe_id #This is where I'm having troubles
        )
    else
      customer = Stripe::Customer.retrieve(customer_id)
      if stripe_token.present?
        customer.card = stripe_token
      end
      customer.email = email
      customer.description = full_name
      customer.save
    end

    self.last_4_digits = customer.cards.data.first["last4"]
    self.customer_id = customer.id
    self.stripe_token = nil

  rescue Stripe::StripeError => e
    logger.error "Stripe Error: " + e.message
    errors.add :base, "#{e.message}"
    self.stripe_token = nil
    false
  end

  private

  def generate_slug
    if name.present?
      self.slug ||= name.parameterize
    end
  end

  def parameterize(sep = '-')
    # replace accented chars with their ascii equivalents
    parameterized_string = self.dup
    # Turn unwanted chars into the separator
    parameterized_string.gsub!(/[^a-z0-9\-_]+/i, sep)
    unless sep.nil? || sep.empty?
      re_sep = Regexp.escape(sep)
      # No more than one of the separator in a row.
      parameterized_string.gsub!(/#{re_sep}{2,}/, sep)
      # Remove leading/trailing separator.
      parameterized_string.gsub!(/^#{re_sep}|#{re_sep}$/i, '')
    end
    parameterized_string.downcase
  end

  def set_defaults
    self.role ||= Role.member

    true
  end
end
