class RecommendationMailer < ActionMailer::Base

  def send_recommendation recommendation
    @text = recommendation.text
    @sender = recommendation.sender
    @recipient = recommendation.recipient
    @book = recommendation.book
    mail(from: @sender.email, to: @recipient.email, subject: "Book Recommendation", body: @text) do |format|
      format.text
      format.html
    end
  end

end
