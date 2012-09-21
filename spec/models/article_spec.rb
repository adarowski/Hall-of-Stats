require 'spec_helper'

describe Article do
  describe 'published_at' do
    it "gets filled in if blank when published is changed" do
      article = create(:unpublished_article)

      article.reload.published_at.should be_nil

      article.update_attribute(:published, true)

      article.reload.published_at.should_not be_nil
    end

    it "is not updated if the article was already published" do
      pub_at = 1.day.ago

      article = create(:published_article, published_at: pub_at)

      article.reload.published_at.should == pub_at

      article.update_attribute(:published, false)
      article.update_attribute(:published, true)

      article.reload.published_at.should == pub_at

    end
  end
end
