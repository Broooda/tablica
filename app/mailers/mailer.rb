class Mailer < ActionMailer::Base
  default from: "trolololo@gmail.com"


   def raport(recipient, raport)
    @recipient = recipient
    @raport = raport
    mail(to: recipient,
         subject: "Welcome #{recipient}")
  end

end
