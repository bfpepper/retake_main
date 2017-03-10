class MovieNotifierMailer < ApplicationMailer
  default from: 'any_from_address@example.com'

  def movie_email(email, title)
    @title = title
    mail( to: email, subject: "A movie was jsut addded to your account." )
  end
end
