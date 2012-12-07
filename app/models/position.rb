class Position < ActiveHash::Base
  fields :img, :img_credit

  # Adam: replace this with real data
  add id: 'c', img: 'foxx.jpg', img_credit: 'http://www.flickr.com/photos/boston_public_library/5887848576/'
end
