class UpdatePrismicContentsJob < ApplicationJob
  queue_as :default

  def perform(model, page = 1, received_ids = [])
    prismic_client = Prismic::Client.new
    @model = model.constantize
    @received_ids = received_ids
    @prismic_response = prismic_client.public_send("#{@model.name.underscore.downcase}s", page)

    reindex_all_contents

    perform(model, page + 1, @received_ids) if next_page?
    update_publication_status if last_page?
  end

  private

  def next_page?
    @prismic_response.next_page
  end

  def last_page?
    @prismic_response.next_page.blank?
  end

  def reindex_all_contents
    @prismic_response.results.each do |prismic_content|
      @received_ids.push(prismic_content.prismic_id)
      project_from_db = @model.find_by(prismic_id: prismic_content.prismic_id)
      if project_from_db
        project_from_db.update(prismic_content.to_hash)
      else
        @model.create(prismic_content.to_hash)
      end
    end
  end

  def update_publication_status
    @model.pluck(:prismic_id).each do |prismic_id|
      if article_unpublished_from_prismic?(prismic_id)
        @model.find_by(prismic_id: prismic_id).update(published: false)
      end
    end
  end

  def article_unpublished_from_prismic?(prismic_id)
    !@received_ids.include? prismic_id
  end
end
