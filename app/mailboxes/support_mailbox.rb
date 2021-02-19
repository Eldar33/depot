class SupportMailbox < ApplicationMailbox

  # Чтобы протестироваить прием писем можно перейти нпо ссылке
  # http://localhost:3000/rails/conductor/action_mailbox/inbound_emails
  # и отправить письмо на support@example.com
  # результат можно посмотреть в логе сервера Rails 
  def process
    puts "START SupportMailbox#process:"
    puts "From   : #{mail.from_address}"
    puts "Subject: #{mail.subject}"
    puts "Body   : #{mail.body}"
    puts "END SupportMailbox#process"

    recent_order = Order.where(email: mail.from_address.to_s).order('created_at desc').first

    SupportRequest.create!(
        email: mail.from_address.to_s,
        subject: mail.subject,
        body: mail.body.to_s,
        order: recent_order
      )    
  end
end

  #   def process
  #     recent_order = Order.where(email: mail.from_address.to_s).
  #                          order('created_at desc').
  #                          first

  #     SupportRequest.create!(
  #       email:   mail.from_address.to_s,
  #       subject: mail.subject,
  #       body:    mail.body.to_s,
  #       order:   recent_order
  #     )
  # end

