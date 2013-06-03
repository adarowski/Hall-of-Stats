class Position < ActiveHash::Base
  fields :img, :img_credit, :player
  field :num_displayed_players, default: 200

  add id: 'c', img: 'schanwa01', img_credit: 'http://www.flickr.com/photos/library_of_congress/6106497932/', player: 'Wally Schang'
  add id: '1b', img: 'bottoji01', img_credit: 'http://www.flickr.com/photos/boston_public_library/6383740299/', player: 'Jim Bottomley'
  add id: '2b', img: 'lajoina01', img_credit: 'http://www.flickr.com/photos/library_of_congress/8190451125/', player: 'Nap Lajoie'
  add id: '3b', img: 'bakerfr01', img_credit: 'http://www.flickr.com/photos/library_of_congress/6083721076/', player: 'Frank Baker'
  add id: 'ss', img: 'peskyjo01', img_credit: 'http://www.flickr.com/photos/boston_public_library/6082750550/', player: 'Johnny Pesky'
  add id: 'lf', img: 'mageesh01', img_credit: 'http://en.wikipedia.org/wiki/File:Sherry_Magee_circa_1911.jpg/', player: 'Sherry Magee'
  add id: 'cf', img: 'cobbty01', img_credit: 'http://www.loc.gov/pictures/item/ggb2004008006/', player: 'Ty Cobb'
  add id: 'rf', img: 'crawfsa01', img_credit: 'http://www.loc.gov/pictures/item/hec2008001928/', player: 'Sam Crawford'
  add id: 'dh', img: 'thomafr04', img_credit: 'http://www.flickr.com/photos/benandclare/8201109655/',
    num_displayed_players: 25, player: 'Frank Thomas'
  add id: 'p', img: 'fellebo01', img_credit: 'http://www.flickr.com/photos/boston_public_library/6326061609/',
    num_displayed_players: 500, player: 'Bob Feller'
end
