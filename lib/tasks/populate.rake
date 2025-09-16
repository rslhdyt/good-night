namespace :populate do
  task milion_sleeps: :environment do
    users = User.all.to_a
    now = Time.now

    users.each do |user|
      sleep_records = []
      puts "Generating sleep records for user #{user.id}"

      puts "Generating #{500_000} sleep records for user #{user.id}"
      500_000.times do |i|
        sleep_start = now + i.days
        sleep_end = sleep_start + rand(1..10).hours
        duration = sleep_end - sleep_start

        sleep_records << Sleep.new(
          user_id: user.id,
          sleep_start: sleep_start,
          sleep_end: sleep_end,
          duration: duration
        )
      end

      puts "Bulk inserting #{sleep_records.count} sleep records for user #{user.id}"
      # Bulk insert in batches to avoid memory issues
      sleep_records.each_slice(10_000) do |batch|
        Sleep.import batch
      end
    end
  end
end
