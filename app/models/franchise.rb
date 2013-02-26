class Franchise < ActiveHash::Base
  fields :location, :name, :img, :img_credit, :player
  field :num_displayed_players, default: 200

  add id: 'bos', location: 'Boston', name: 'Red Sox', img: 'peskyjo01.jpg', img_credit: 'http://www.flickr.com/photos/boston_public_library/6082750550/', player: 'Johnny Pesky'
end
