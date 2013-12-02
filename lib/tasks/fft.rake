namespace :fft do
  desc 'Prepare database for food for thought'

  task :initialize do
    #todo check to see if postgres is installed, if it is, get data directory, if not, display an error and link to download postgres
    system('export PGPORT=5432')
    system('export PGHOST=localhost')
    system('createuser food_for_thought -d -s')
    #todo check to see if successful, only display following message if it worked
    #system("echo 'User food_for_thought created on postgres db@localhost:4000'")
  end

  task :reminder_emails => :environment do
    User.users_without_current_orders.each do |user|
      user_email = user.email
      UserMailer.reminder_email(user_email).deliver
      puts "Time almost up mail sent to: #{user_email}"
    end
  end

  task :order_up_notification => :environment do
    User.notification_emails.each do |user_email|
      UserMailer.order_up_email(user_email).deliver
      puts "Order available mail sent to: #{user_email}"
    end
  end
end