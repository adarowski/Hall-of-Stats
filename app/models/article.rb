class Article < ActiveRecord::Base
  attr_accessible :body, :published, :title, as: :admin
end
