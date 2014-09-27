class Post < ActiveRecord::Base
  before_validation :set_defaults

  module States
    DRAFT = 'draft'
    PREVIEW = 'preview'
    PUBLISHED = 'published'

    ALL = [DRAFT, PREVIEW, PUBLISHED]
  end

  # Validations
  validates :name, presence: true
  validates :state, inclusion: { in: States::ALL }

  # Scopes
  def self.published
    where(state: States::PUBLISHED)
  end

  # Instance Methods

  private

  def set_defaults
    self.state ||= 'draft'

    true
  end
end
