class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable

  extend ActiveHash::Associations::ActiveRecordExtensions

  before_validation :generate_slug
  before_validation :set_defaults

  # Associations
  belongs_to_active_hash :role


  # Validations
  validates :full_name, presence: true
  validates :role, inclusion: { in: Role.all }
  validates :slug, presence: true
  validates :website, url: { allow_blank: true, allow_nil: true}

  # Delegations
  delegate :admin?, to: :role
  delegate :member?, to: :role

  # Instance Methods

  # def name
  #   [first_name, last_name].join(' ')
  # end

  private

  def generate_slug
    if full_name.present?
      self.slug ||= full_name.parameterize
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
