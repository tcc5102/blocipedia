class TestMailer < ApplicationMailer
  default from: "tyler.cooper91@gmail.com"

  def new_user_email(user)

    headers["Message-ID"] = "<test/@mailtrap.io>"
    headers["In-Reply-To"] = "<tyler/@mailtrap.io>"
    headers["References"] = "<new member/@mailtrap.io>"

    @user = user

    mail(to: user.email, subject: "Your new account is ready with Blocipedia")

  end
end
