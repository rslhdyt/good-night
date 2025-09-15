class CreateSleeps < ActiveRecord::Migration[8.0]
  def change
    create_table :sleeps do |t|
      t.references :user, null: false, foreign_key: true
      t.datetime :sleep_start
      t.datetime :sleep_end
      t.integer :duration
      t.timestamps
    end
  end
end
