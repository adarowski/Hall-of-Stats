class Absolutizer
  def self.absolutize_html(html_string, host_href)
    doc = Nokogiri::HTML.fragment(html_string)
    [['img', 'src'], ['a', 'href']].each do |tag, attr|
      doc.css(tag).each do |el|
        el[attr] = "#{host_href}#{el[attr]}" unless absolute?(el[attr])
      end
    end

    doc.to_html
  end

  private

  def self.absolute?(url)
    url.match(/^http(s)?\:\/\//)
  end
end
