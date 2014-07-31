class Mailer < ActionMailer::Base
  default from: "trolololo@gmail.com"


   def raport(recipient, raport)
    @recipient = recipient

    attachments['raport.pdf'] = raport

    mail(to: recipient.email,
         subject: "Raport binarplaner")
  end

end
