class WebhooksController < ApplicationController
  skip_before_action :verify_authenticity_token
  http_basic_authenticate_with name: ENV['ZAPIER_WEBHOOK_USER'],
    password: ENV['ZAPIER_WEBHOOK_SECRET'], only: :associates

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

  def associates
    AssociatesUpdate.first.update_attributes({
      total_raised: params['total_raised'],
      total_associates: params['total_associates'],
      last_associate_name_1: params['last_associate_name_1'],
      last_associate_shares_1: params['last_associate_shares_1'],
      last_associate_date_1: params['last_associate_date_1'],
      last_associate_name_2: params['last_associate_name_2'],
      last_associate_shares_2: params['last_associate_shares_2'],
      last_associate_date_2: params['last_associate_date_2'],
      last_associate_name_3: params['last_associate_name_3'],
      last_associate_shares_3: params['last_associate_shares_3'],
      last_associate_date_3: params['last_associate_date_3']
    })
    head :no_content
  end
end
