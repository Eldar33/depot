require 'test_helper'

class SupportRequestMailerTest < ActionMailer::TestCase
  test "respond" do
    sr = support_requests(:one)
    mail = SupportRequestMailer.respond(sr)
    assert_equal "Re: ", mail.subject
    assert_equal ["support@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
