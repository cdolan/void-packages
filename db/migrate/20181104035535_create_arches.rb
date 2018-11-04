class CreateArches < ActiveRecord::Migration[5.2]
  def change
    create_table :arches do |t|
      t.string :name, null: false
    end

    add_index :arches, :name, unique: true
  end
end
