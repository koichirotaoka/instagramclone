class PictureMailer < ApplicationMailer
  def picture_mail(picture)
    @picture = picture
    mail to: @picture.user.email, subject: "投稿しました"
  end
end
