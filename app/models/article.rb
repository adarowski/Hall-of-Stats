class Article < ActiveRecord::Base
  attr_accessible :body, :published, :title, :published_at, as: :admin

  scope :published, where("published_at is not null")
  scope :by_published_at, order("published_at desc")

  before_save :set_associated_players
  before_save :set_published_at, if: :published?

  has_and_belongs_to_many :players

  def formatted_body
    BioFormatter.new(body).to_s
  end

  private

  def set_associated_players
    self.players = BioFormatter.new(body).mentioned_players
  end

  def set_published_at
    self.published_at ||= Time.now
  end
end
