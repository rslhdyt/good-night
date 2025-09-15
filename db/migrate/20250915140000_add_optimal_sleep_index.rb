class AddOptimalSleepIndex < ActiveRecord::Migration[8.0]
  def change
    add_index :sleeps, [:user_id, :duration, :created_at],
              name: "idx_sleeps_user_duration_date",
              order: { duration: :desc },
              where: "duration IS NOT NULL"
  end
end