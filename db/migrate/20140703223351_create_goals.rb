class CreateGoals < ActiveRecord::Migration
  def change
    create_table :goals do |t|
      t.integer :user_id, null: false
      t.boolean :public, null: false
      t.boolean :completed, null: false
      t.string :title, null: false

      t.timestamps
    end
    add_index :goals, :user_id
    add_index :goals, :public
    add_index :goals, :completed
    add_index :goals, :title
  end
end
