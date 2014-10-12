class Plan < ActiveHash::Base
  include ActiveHash::Associations

  self.data = [
    { id: 0, name: 'Americano' },
    { id: 1, name: 'Caramel Latte' },
    { id: 2, name: 'Latte' },
    { id: 3, name: 'Esperesso' },
    { id: 4, name: 'Executive Producer' }
  ]

  has_many :users

  {
    americano: 0,
    caramel_latte: 1,
    latte: 2,
    espresso: 3,
    executive_producer: 4
  }.each do |method, key|
    (class << self; self; end).instance_eval do
      define_method method do
        find key
      end
    end
  end
end
