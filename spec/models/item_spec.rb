require 'rails_helper'

# Test suite for Item model.
RSpec.describe Item, type: :model do
  # Association Tests. ------------------------------
  # Ensure an item record belongs to a single todo record.
  it { should belong_to(:todo) }

  # Validation Tests. -------------------------------
  # Ensure column title and created_by are present before saving.
  it { should validate_presence_of(:name) }
end
