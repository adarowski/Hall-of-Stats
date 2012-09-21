class Article < ActiveRecord::Base
  attr_accessible :body, :published, :title, :published_at, as: :admin

  scope :published, where("published_at is not null")

  before_save :set_published_at, if: :published?

  private

  def set_published_at
    self.published_at ||= Time.now
  end
end
