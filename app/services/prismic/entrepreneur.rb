module Prismic
  class Entrepreneur
    include Rails.application.routes.url_helpers

    @text_attributes = %i[name description position]
    @image_attributes = %i[picture]

    attr_reader :prismic_id

    def initialize(entrepreneur)
      @entrepreneur   = entrepreneur
      @prismic_id = entrepreneur.id
    end

    def self.attributes
      [
        @text_attributes,
        @image_attributes.map { |attribute| %I(#{attribute}_url #{attribute}_alt) },
        :prismic_id,
        :project_id
      ].flatten
    end

    @text_attributes.each do |field|
      define_method(field) do
        if @entrepreneur["#{@entrepreneur.type}.#{field}"].present?
          @entrepreneur["#{@entrepreneur.type}.#{field}"].as_text
        end
      end
    end

    @image_attributes.each do |field|
      define_method("#{field}_url") do
        if @entrepreneur["#{@entrepreneur.type}.#{field}"].present?
          @entrepreneur["#{@entrepreneur.type}.#{field}"].url
        end
      end

      define_method("#{field}_alt") do
        if @entrepreneur["#{@entrepreneur.type}.#{field}"].present?
          @entrepreneur["#{@entrepreneur.type}.#{field}"].alt
        end
      end
    end

    def project_id
      if @entrepreneur["#{@entrepreneur.type}.project"].present?
        ::Project.find_by(prismic_id: @entrepreneur["#{@entrepreneur.type}.project"].id)&.id
      end
    end
  end
end
