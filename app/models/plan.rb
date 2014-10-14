class Plan < ActiveHash::Base
  include ActiveHash::Associations

  self.data = [
    { id: 0, name: 'Americano', stripe_id: '-5-month_CMCU8401Fu', price: '$5.00' },
    { id: 1, name: 'Caramel Latte', stripe_id: 'carmel-latte_CMCU8401Fu', price: '$19.00' },
    { id: 2, name: 'Latte', stripe_id: '-20-month_CMCU8401Fu', price: '$20.00' },
    { id: 3, name: 'Esperesso', stripe_id: 'espresso_CMCU8401Fu', price: '$100.00' },
    { id: 4, name: 'Executive Producer', stripe_id: 'executive-producer_CMCU8401Fu', price: '$875.00' }
  ]

  has_many :users

  def plan_name
    [name, price].join(' - ')
  end

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
