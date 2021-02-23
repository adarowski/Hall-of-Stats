class Article < ActiveRecord::Base
  paginates_per 10

  # attr_accessible :body, :published, :title, :slug, :published_at, as: :admin

  scope :published, ->{where("published_at is not null")}
  scope :by_published_at, ->{order("published_at desc")}

  before_save :set_associated_players
  before_save :set_published_at, if: :published?

  validates_uniqueness_of :slug

  has_and_belongs_to_many :players

  def self.find_by_slug_or_id(slug_or_id)
    where(slug: slug_or_id).first || find(slug_or_id)
  end

  def formatted_body
    BioFormatter.new(body).to_s
  end

  def to_param
    slug.present? ? slug : id
  end

  def article_params
    params.require(:article).permit(:body, :published, :title, :slug, :published_at)
  end

  private

  def set_associated_players
    self.players = BioFormatter.new(body).mentioned_players
  end

  def set_published_at
    self.published_at ||= Time.now
  end
end
