module Prismic
  class HighlightedContentSerializer < ContentSerializer

    def initialize(project)
      super(project)
      serialize_project_id
    end

    def serialize_project_id
      if @content["#{@content.type}.highlighted_project"].present?
        @attributes['project_id'] = ::Project.find_by(prismic_id: @content["#{@content.type}.highlighted_project"].id)&.id
      end
    end
  end
end
