class Post < ActiveRecord::Base
  extend FriendlyId

  before_validation :generate_slug
  before_validation :set_defaults

  friendly_id :slug, use: :finders

  module States
    DRAFT = 'draft'
    PREVIEW = 'preview'
    PUBLISHED = 'published'

    ALL = [DRAFT, PREVIEW, PUBLISHED]
  end

  # Validations
  validates :title, presence: true
  validates :state, inclusion: { in: States::ALL }
  validates :slug, presence: true, uniqueness: true, format: { with: /\A[a-z0-9\-]+\z/, message: 'only letters, numbers and dashes allowed' }


  # Scopes
  def self.published
    where(state: States::PUBLISHED)
  end

  # Instance Methods

  private

  def generate_slug
    if title.present?
      self.slug ||= title.parameterize
    end
  end

  def set_defaults
    self.state ||= 'draft'

    true
  end
end
