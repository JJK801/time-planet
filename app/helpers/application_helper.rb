module ApplicationHelper

  def embedded_svg filename, options={}
    file = File.read(Rails.root.join('app', 'assets', 'images', filename))
    doc = Nokogiri::HTML::DocumentFragment.parse file
    svg = doc.at_css 'svg'
    if options[:class].present?
      svg['class'] = options[:class]
    end
    doc.to_html.html_safe
  end

  def get_host_without_www(url)
    return if url.blank?

    uri = URI.parse(url)
    uri = URI.parse("http://#{url}") if uri.scheme.nil?
    host = uri.host.downcase
    host.start_with?('www.') ? host[4..-1] : host
  end

  def current_translations
    @translations ||= I18n.backend.send(:translations)
    if @translations.blank?
      @translations
    else
      @translations[I18n.locale].with_indifferent_access
    end
  end
end
