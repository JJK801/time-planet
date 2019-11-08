module Prismic
  class ProjectSerializer < ContentSerializer

    def initialize(project)
      super(project)
      @attributes['slug'] = @content.uid
    end

    def self.text_attributes
      %w(title meta_title meta_description project_url funding_status long_summary short_summary
       quote keyword_1 icon_1 keyword_2 icon_2 keyword_3 icon_3 keyword_4 icon_4)
    end

    def self.image_attributes
      %w(cover_image secondary_image_1 secondary_image_2 project_logo)
    end

    def self.html_attributes
      %w(description)
    end
  end
end
