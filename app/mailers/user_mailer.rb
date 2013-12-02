class UserMailer < ActionMailer::Base
  default from: 'tw.food.for.thought@gmail.com'

  def reminder_email(user_email)
    @url  = 'http://tw-food-for-thought.herokuapp.com'
    mail(to: user_email, subject: 'Make your food for thought order within 30 minutes!')
  end

  def order_up_email(user_email)
    @url  = 'http://tw-food-for-thought.herokuapp.com'
    date = Time.now.strftime('%A, %b%e - %Y')
    mail(to: user_email, subject: "Food for thought orders are available for today! (#{date})")
  end
end
