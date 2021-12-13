Rails.application.routes.draw do
  # We’re creating a Todos resource with a nested Items resource.
  # This enforces the 1:m associations at the routing level.
  resources(:todos) do
    resources(:items)
  end
end
