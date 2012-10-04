xml.instruct! :xml, version: "1.0" 
xml.rss version: "2.0" do
  xml.channel do
    xml.title "Hall Of Stats"
    xml.description "An alternate Hall of Fame populated by a mathematical formula."
    xml.link articles_url

    @articles.each do |article|
      xml.item do
        xml.title article.title
        xml.description absolutize(article.formatted_body)
        xml.pubDate article.published_at.to_s(:rfc822)
        xml.link article_url(article)
        xml.guid article_url(article)
      end
    end
  end
end
