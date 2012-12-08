class Position < ActiveHash::Base
  fields :img, :img_credit

  # Adam: replace this with real data
  add id: 'c', img: 'schanwa01.jpg', img_credit: 'http://www.flickr.com/photos/library_of_congress/6106497932/'
  add id: '1b', img: 'bottoji01.jpg', img_credit: 'http://www.flickr.com/photos/boston_public_library/6383740299/'
  add id: '2b', img: 'lajoina01.jpg', img_credit: 'http://www.flickr.com/photos/library_of_congress/8190451125/'
  add id: '3b', img: 'bakerfr01.jpg', img_credit: 'http://www.flickr.com/photos/library_of_congress/6083721076/'
  add id: 'ss', img: 'peskyjo01.jpg', img_credit: 'http://www.flickr.com/photos/boston_public_library/6082750550/'
  add id: 'lf', img: 'mageesh01.jpg', img_credit: 'http://en.wikipedia.org/wiki/File:Sherry_Magee_circa_1911.jpg/'
  add id: 'cf', img: 'cobbty01.jpg', img_credit: 'http://www.loc.gov/pictures/item/ggb2004008006/'
  add id: 'rf', img: 'crawfsa01.jpg', img_credit: 'http://www.loc.gov/pictures/item/hec2008001928/'
  add id: 'dh', img: 'thomafr04.jpg', img_credit: 'http://www.flickr.com/photos/benandclare/8201109655/'
  add id: 'p', img: 'fellebo01.jpg', img_credit: 'http://www.flickr.com/photos/boston_public_library/6326061609/'
end
