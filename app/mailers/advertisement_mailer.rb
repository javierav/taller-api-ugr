class AdvertisementMailer < ApplicationMailer
  def created_email
    @advertisement = params[:advertisement]
    mail(to: @advertisement.author_email, subject: 'New advertisement created')
  end
end
