module ArticlesHelper
  def article_truncation(article)
    BioFormatter.new(
      truncate(article.body, length: 1000, separator: "\n",
        omission: link_to("Read More", article_path(article), class: 'more')
    )).to_s
  end
end
