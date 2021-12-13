class CreateItems < ActiveRecord::Migration[6.1]
  def change
    create_table :items do |t|
      t.string :name
      t.boolean :done
      # Adds foreign key column "todo_id" to the items table.
      # Also makes the "belongs_to" association.
      t.references :todo, null: false, foreign_key: true

      t.timestamps
    end
  end
end
