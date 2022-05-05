# Preview all emails at http://localhost:5000/rails/mailers/user
class UserPreview < ActionMailer::Preview
  def confirmation_email
    user = User.first
    token_expiration_time = '60分'
    magic_link = 'http://localhost:3000/login_with_email?token=eyJfcmFpbHMiOnsibWVzc2FnZSI6Ik1qVT0iLCJleHAiOiIyMDIyLTA1LTA0VDA4OjE2OjU4LjA2MVoiLCJwdXIiOiJ1c2VyL2VtYWlsX2FjdGl2YXRlIn19--b4a2b10f6c3e2194d04a244400953e4273921149610dbe1fbef153a3f49399f3&password=4NiYx3eLZcRCR5z8xz5u'

    UserMailer.confirmation_email(user, magic_link, token_expiration_time)
  end

  def reset_email
    user = User.first
    token_expiration_time = '60分'
    magic_link = 'http://localhost:3000/update_email?token=eyJfcmFpbHMiOnsibWVzc2FnZSI6Ik1qVT0iLCJleHAiOiIyMDIyLTA1LTA0VDA4OjE2OjU4LjA2MVoiLCJwdXIiOiJ1c2VyL2VtYWlsX2FjdGl2YXRlIn19--b4a2b10f6c3e2194d04a244400953e4273921149610dbe1fbef153a3f49399f3'

    UserMailer.reset_email(user, magic_link, token_expiration_time)
  end

  def reset_password
    user = User.first
    token_expiration_time = '60分'
    magic_link = 'http://localhost:3000/update_password?token=eyJfcmFpbHMiOnsibWVzc2FnZSI6Ik1qVT0iLCJleHAiOiIyMDIyLTA1LTA0VDA4OjE2OjU4LjA2MVoiLCJwdXIiOiJ1c2VyL2VtYWlsX2FjdGl2YXRlIn19--b4a2b10f6c3e2194d04a244400953e4273921149610dbe1fbef153a3f49399f3'

    UserMailer.reset_password(user, magic_link, token_expiration_time)
  end
end
