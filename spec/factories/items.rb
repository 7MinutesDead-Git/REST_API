# Factory Bot for generating test data for Items model.
FactoryBot.define do
  factory(:item) do
    name { Faker::StarWars.character }
    done { false }
    todo_id { nil}
  end
end