# Factory Bot for generating test data for Todo  model.
FactoryBot.define do
  factory(:todo) do
    # By wrapping Faker methods in a block, we ensure that Faker generates
    # dynamic data every time the factory is invoked so data is always unique.
    title { Faker::Ancient.god }
    created_by { Faker::Number.number(digits: 10) }
  end
end
