class ApplicationMailer < ActionMailer::Base
  default from: 'from@example.com'
  layout 'mailer'

  def send_mail
    mail( to: "reqdeq@yandex.ru",
          subject: "New subject",
          body: "Some text",
          from: "abs@abs.com",
          charset: 'utf-8')
  end
  
end
