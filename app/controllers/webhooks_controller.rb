class WebhooksController < ApplicationController
  skip_before_action :verify_authenticity_token

  def prismic
    if (params['secret'] == ENV['PRISMIC_WEBHOOK_SECRET'])
      UpdatePrismicContentsJob.perform_later(Project.name)
      UpdatePrismicContentsJob.perform_later(Entrepreneur.name)
      UpdatePrismicContentsJob.perform_later(HighlightedContent.name)
      head :no_content
    else
      head :unauthorized
    end
  end
end
