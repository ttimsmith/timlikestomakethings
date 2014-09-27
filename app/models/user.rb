class User < ActiveRecord::Base
  before_validation :generate_slug


  # Validations
  validates :full_name, presence: true
  validates :slug, presence: true
  validates :website, url: { allow_blank: true, allow_nil: true}

  # Instance Methods

  private

  def generate_slug
    if first_name.present? && last_name.present?
      self.slug ||= [full_name].map(&:downcase).join('_')
    end
  end
end
