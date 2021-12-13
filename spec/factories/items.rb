# Factory Bot for generating test data for Items model.
FactoryBot.define do
  factory(:item) do
    name { Faker::GreekPhilosophers.name }
    done { false }
    todo_id { nil}
  end
end