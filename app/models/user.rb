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
      self.slug ||= full_name.map(&:downcase).join('_')
    end
  end

  def set_defaults
    self.role ||= Role.member

    true
  end
end
