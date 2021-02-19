class ApplicationMailbox < ActionMailbox::Base
  # routing /something/i => :somewhere
  # Эта запись говорит Rails, что любое письмо на ящик support@example.com
  # необходимо обработать в классе SupportMailbox
  routing "support@example.com" => :support
end
