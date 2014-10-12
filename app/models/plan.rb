class Plan < ActiveHash::Base
  include ActiveHash::Associations

  self.data = [
    { id: 0, name: 'Free'},
    { id: 1, name: 'Americano' },
    { id: 2, name: 'Caramel Latte' },
    { id: 3, name: 'Latte' },
    { id: 4, name: 'Esperesso' },
    { id: 5, name: 'Executive Producer' }
  ]

  has_many :users

  {
    free: 0,
    americano: 1,
    caramel_latte: 2,
    latte: 3,
    espresso: 4,
    executive_producer: 5
  }.each do |method, key|
    (class << self; self; end).instance_eval do
      define_method method do
        find key
      end
    end
  end
end
