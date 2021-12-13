require 'rails_helper'

# Test suite for "To do" model.
RSpec.describe Todo, type: :model do
  # Association Tests. ------------------------------
  # Ensure "To do" model has 1:m relationship with Item model.
  it { should have_many(:items).dependent(:destroy) }

  # Validation Tests. -------------------------------
  # Ensure column title and created_by are present before saving.
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:created_by) }
end
