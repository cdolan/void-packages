class CreatePackages < ActiveRecord::Migration[5.2]
  def change
    create_table :packages do |t|
      t.string :name, null: false
      t.string :homepage
      t.string :license, null: false
      t.string :maintainer
      t.string :version, null: false
      t.integer :revision, null: false
      t.string :description
      t.string :source_revision

      t.timestamps null: false
    end

    add_index :packages, :name, unique: true
  end
end
