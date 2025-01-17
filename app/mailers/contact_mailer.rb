class ContactMailer < ApplicationMailer
  default from: 'xyli17114@gmail.com'

  def contact_email(contact)
    @contact = contact
    mail(
      to: 'xyli17114@gmail.com',
      subject: '新しいお問い合わせが届きました'
    )
  end
end
