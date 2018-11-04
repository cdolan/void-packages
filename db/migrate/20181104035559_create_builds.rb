class CreateBuilds < ActiveRecord::Migration[5.2]
  def change
    create_table :builds do |t|
      t.belongs_to :arch,
        null: false,
        foreign_key: { on_delete: :cascade }

      t.belongs_to :package,
        null: false,
        foreign_key: { on_delete: :cascade }

      t.datetime :build_date, null: false
      t.string :filename_sha256, null: false
      t.bigint :filename_size, null: false
      t.bigint :installed_size, null: false
    end

    add_index :builds, %i[arch_id package_id], unique: true
  end
end
