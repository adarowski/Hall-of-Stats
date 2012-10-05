require 'spec_helper'

describe ArticlesController do
  describe '#index' do
    context ".rss" do
      render_views

      let!(:article_1)   { create(:published_article, title: "title 1", body: "body 1") }
      let!(:article_2)   { create(:published_article, title: "title 2", body: "body 2") }
      let!(:unpublished) { create(:unpublished_article, title: "title 3", body: "body 3") }

      before { get :index, format: :rss }
      subject { response.body }

      it { should include(article_1.title) }
      it { should include(article_1.body) }

      it { should include(article_2.title) }
      it { should include(article_2.body) }

      it { should_not include(unpublished.title) }
      it { should_not include(unpublished.body) }

      it { should include('<title>Hall Of Stats</title>') }
    end
  end
end
