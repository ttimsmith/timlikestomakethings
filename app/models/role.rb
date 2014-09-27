class Role < ActiveHash::Base
  include ActiveHash::Associations

  self.data = [
    { id: 0, name: 'Member', member: true },
    { id: 1, name: 'Admin', member: true, admin: true },
  ].map do |t|
    { admin: false }.merge(t)
  end

  def to_s
    name
  end

  has_many :users

  # Dynamically define Role.user and Role.admin
  {
    member: 0,
    admin: 1,
  }.each do |method, key|
    (class << self; self; end).instance_eval do
      define_method method do
        find key
      end
    end
  end
end
