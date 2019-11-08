module Prismic
  class ContentSerializer

    attr_reader :prismic_id

    def initialize(content)
      @content = content
      @prismic_id = content.id
      @attributes = {}
      @attributes['prismic_id'] = @content.id
      @attributes['published'] = true
      serialize_html_attributes
      serialize_text_attributes
      serialize_image_attributes
    end

    def self.text_attributes
      []
    end

    def self.image_attributes
      []
    end

    def self.html_attributes
      []
    end

    def serialize_text_attributes
      self.class.text_attributes.each do |attribute|
        if @content["#{@content.type}.#{attribute}"].present?
          @attributes[attribute] = @content["#{@content.type}.#{attribute}"].as_text
        end
      end
    end

    def serialize_image_attributes
      self.class.image_attributes.each do |attribute|
        if @content["#{@content.type}.#{attribute}"].present?
          @attributes["#{attribute}_url"] = @content["#{@content.type}.#{attribute}"].url
          @attributes["#{attribute}_alt"] = @content["#{@content.type}.#{attribute}"].alt
        end
      end
    end

    def serialize_html_attributes
      self.class.html_attributes.each do |attribute|
        if @content["#{@content.type}.#{attribute}"].present?
          @attributes[attribute] = @content["#{@content.type}.#{attribute}"].as_html(nil).html_safe
        end
      end
    end

    def to_hash
      @attributes
    end
  end
end
