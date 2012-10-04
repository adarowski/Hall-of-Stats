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
      pub_at = 1.day.ago.to_s

      article = create(:published_article, published_at: pub_at)

      article.reload.published_at.to_s.should == pub_at

      article.update_attribute(:published, false)
      article.update_attribute(:published, true)

      article.reload.published_at.to_s.should == pub_at
    end
  end

  describe 'setting mentioned players on save' do
    let!(:player_1) { create(:player) }
    let!(:player_2) { create(:player) }
    let!(:unmentioned_player) { create(:player) }

    subject(:article) { build(:article, body: "I like @#{player_1.id} and @#{player_2.id}") }

    it "associates mentioned players with the article" do
      article.save

      article.players.should =~ [player_1, player_2]
    end
  end
end
