class ArticleDecorator < Draper::Decorator
  decorates :article

  delegate_all

  def keywords
    [
      "Hall of Stats",
      "articles",
      article.title,
      article.players[0...3].map(&:name),
      "Sabermetrics"
    ].flatten.join(",")
  end
end
