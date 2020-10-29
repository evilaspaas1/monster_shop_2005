FactoryBot.define do 
  factory :item do 
    association :merchant, factory: :item
  end
end