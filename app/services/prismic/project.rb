module Prismic
  class Project
    include Rails.application.routes.url_helpers

    @text_attributes = %i[title meta_title meta_description project_url funding_status long_summary short_summary
       description quote keyword_1 icon_1 keyword_2 icon_2 keyword_3 icon_3 keyword_4 icon_4]
    @image_attributes = %i[cover_image secondary_image_1 secondary_image_2 project_logo]

    attr_reader :slug, :prismic_id

    def initialize(project)
      @project   = project
      @slug       = project.uid
      @prismic_id = project.id
    end

    def self.attributes
      [
        @text_attributes,
        @image_attributes.map { |attribute| %W(#{attribute}_url #{attribute}_alt) },
        'slug',
        'prismic_id',
        'description'
      ].flatten
    end

    @text_attributes.each do |field|
      define_method(field) do
        if @project["#{@project.type}.#{field}"].present?
          @project["#{@project.type}.#{field}"].as_text
        end
      end
    end

    def description
      if @project["#{@project.type}.description"].present?
        @project["#{@project.type}.description"]
          .as_html(nil)
          .html_safe
      end
    end

    @image_attributes.each do |field|
      define_method("#{field}_url") do
        if @project["#{@project.type}.#{field}"].present?
          @project["#{@project.type}.#{field}"].url
        end
      end

      define_method("#{field}_alt") do
        if @project["#{@project.type}.#{field}"].present?
          @project["#{@project.type}.#{field}"].alt
        end
      end
    end
  end
end
