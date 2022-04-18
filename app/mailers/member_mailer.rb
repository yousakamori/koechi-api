class MemberMailer < ApplicationMailer
  def member_email(member, space)
    @member = member
    @space = space
    mail to: member.email, subject: '招待のご確認'
  end
end
