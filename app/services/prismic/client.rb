# Allow to call the Prismic API (prismic.io = CMS used to publish content)
module Prismic
  class Client
    URL = 'https://time-planet.cdn.prismic.io/api'.freeze

    def initialize
      @api = Prismic.api(URL, ENV['TOKEN_PRISMIC'])
    end

    def projects(page_number = 1)
      response = @api.query(
        Prismic::Predicates.at('document.type', 'projets'),
        { "page" => page_number, "pageSize" => 50 }
      )
      response.results = response.results.map do |project|
        Prismic::ProjectSerializer.new(project)
      end
      response
    end

    def entrepreneurs(page_number = 1)
      response = @api.query(
        Prismic::Predicates.at('document.type', 'entrepreneur'),
        { "page" => page_number, "pageSize" => 50 }
      )
      response.results = response.results.map do |entrepreneur|
        Prismic::EntrepreneurSerializer.new(entrepreneur)
      end
      response
    end
  end
end
