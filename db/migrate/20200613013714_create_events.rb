class CreateEvents < ActiveRecord::Migration[6.0]
  def change
    create_table :events do |t|
      t.string :event_type
      t.references :user, null: false, foreign_key: true
      t.datetime :occurred_at
      t.boolean :auto_generated, default: false

      t.timestamps
    end
  end
end
