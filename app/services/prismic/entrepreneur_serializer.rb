module Prismic
  class EntrepreneurSerializer < ContentSerializer

    def initialize(project)
      super(project)
      serialize_project_id
    end

    def self.text_attributes
      %w(name description position)
    end

    def self.image_attributes
      %w(picture)
    end

    def serialize_project_id
      if @content["#{@content.type}.project"].present?
        @attributes['project_id'] = ::Project.find_by(prismic_id: @content["#{@content.type}.project"].id)&.id
      end
    end
  end
end
