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

  # Associations
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :attachments, dependent: :destroy

  # Validations
  validates :title, presence: true
  validates :state, inclusion: { in: States::ALL }
  validates :slug, presence: true, uniqueness: true, format: { with: /\A[a-z0-9\-]+\z/, message: 'only letters, numbers and dashes allowed' }


  # Scopes
  def self.published
    where(state: States::PUBLISHED)
  end

  def self.with_comment_count
    select("
      posts.*,
      (
        SELECT COUNT(*)
        FROM comments
        WHERE posts.id = comments.post_id
      ) AS comment_count
    ").
      references(:comments)
  end

  # Instance Methods

  private

  def generate_slug
    if title.present?
      self.slug ||= title.parameterize
    end
  end

  def set_defaults
    self.state ||= 'published'

    true
  end
end
