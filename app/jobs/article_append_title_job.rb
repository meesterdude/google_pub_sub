class ArticleAppendTitleJob < ApplicationJob
  queue_as :default

  def perform(article, append_text)
    article.update title: article.title + append_text
  end
end
