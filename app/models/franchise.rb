# -*- encoding: utf-8 -*-

class Franchise < ActiveHash::Base
  include ActiveHash::Associations
  
  fields :name, :img, :img_credit, :player, :active, :first_year, :last_year
  field :num_displayed_players, default: 200
  field :active, default: false
  
  has_many :franchise_ratings, class_name: 'FranchiseRating'
  
  def players
    Player.select('players.*, franchise_ratings.hall_rating::numeric as franchise_hall_rating').
      joins(:franchise_ratings).
      where('franchise_ratings.franchise_id = ?', self.id).
      order('franchise_ratings.hall_rating desc')
  end
  
  def players_for_position(position)
    Player.select('players.*, franchise_ratings.hall_rating::numeric as franchise_hall_rating').
      joins(:franchise_ratings).
      where('franchise_ratings.franchise_id = ?', self.id).where('players.position = ?', position).
      order('franchise_ratings.hall_rating desc')
  end
  
  def all_stars
    positions = %w{ 1b 2b 3b ss c cf lf rf p }
    Player.select('distinct on (players.position) players.*, franchise_ratings.hall_rating as franchise_hall_rating').
      joins(:franchise_ratings).
      where('franchise_ratings.franchise_id = ? and players.position in (?)', self.id, positions).
      order('players.position, franchise_hall_rating desc')
  end
  
  def bench
    players.where('id not in (?) and position != ?',
                  all_stars.map(&:id), 'p').limit(7)
  end
  
  def bullpen
    players_for_position('p').offset(1).limit(9)
  end
  
  def self.active
    Franchise.all.select{|f| f.last_year.blank? }
  end
  
  def self.past
    Franchise.all.reject{|f| f.last_year.blank? }
  end
  
  def years_existed
    if last_year.blank?
      "since #{first_year}"
    else
      [first_year, last_year].uniq.join('-')
    end
  end

  add id: 'alt', name: 'Altoona Mountain City', img: 'peskyjo01.jpg', img_credit: 'http://www.flickr.com/photos/boston_public_library/6082750550/', player: 'Johnny Pesky', first_year: '1884', last_year: '1884'
  add id: 'ana', name: 'Los Angeles Angels of Anaheim', active: true, img: 'peskyjo01.jpg', img_credit: 'http://www.flickr.com/photos/boston_public_library/6082750550/', player: 'Johnny Pesky', first_year: '1961'
  add id: 'ari', name: 'Arizona Diamondbacks', active: true, img: 'peskyjo01.jpg', img_credit: 'http://www.flickr.com/photos/boston_public_library/6082750550/', player: 'Johnny Pesky', first_year: '1998'
  add id: 'ath', name: 'Philadelphia Athletics', img: 'peskyjo01.jpg', img_credit: 'http://www.flickr.com/photos/boston_public_library/6082750550/', player: 'Johnny Pesky', first_year: '1876', last_year: '1876'
  add id: 'atl', name: 'Atlanta Braves', active: true, img: 'peskyjo01.jpg', img_credit: 'http://www.flickr.com/photos/boston_public_library/6082750550/', player: 'Johnny Pesky', first_year: '1876'
  add id: 'bal', name: 'Baltimore Orioles', active: true, img: 'peskyjo01.jpg', img_credit: 'http://www.flickr.com/photos/boston_public_library/6082750550/', player: 'Johnny Pesky', first_year: '1901'
  add id: 'bfb', name: 'Buffalo Bisons', img: 'peskyjo01.jpg', img_credit: 'http://www.flickr.com/photos/boston_public_library/6082750550/', player: 'Johnny Pesky', first_year: '1890', last_year: '1890'
  add id: 'bfl', name: 'Buffalo Bisons', img: 'peskyjo01.jpg', img_credit: 'http://www.flickr.com/photos/boston_public_library/6082750550/', player: 'Johnny Pesky', first_year: '1914', last_year: '1915'
  add id: 'blc', name: 'Baltimore Canaries', img: 'peskyjo01.jpg', img_credit: 'http://www.flickr.com/photos/boston_public_library/6082750550/', player: 'Johnny Pesky', first_year: '1872', last_year: '1874'
  add id: 'blo', name: 'Baltimore Orioles', img: 'peskyjo01.jpg', img_credit: 'http://www.flickr.com/photos/boston_public_library/6082750550/', player: 'Johnny Pesky', first_year: '1882', last_year: '1899'
  add id: 'blt', name: 'Baltimore Terrapins', img: 'peskyjo01.jpg', img_credit: 'http://www.flickr.com/photos/boston_public_library/6082750550/', player: 'Johnny Pesky', first_year: '1914', last_year: '1915'
  add id: 'blu', name: 'Baltimore Monumentals', img: 'peskyjo01.jpg', img_credit: 'http://www.flickr.com/photos/boston_public_library/6082750550/', player: 'Johnny Pesky', first_year: '1884', last_year: '1884'
  add id: 'bna', name: 'Boston Red Stockings', img: 'peskyjo01.jpg', img_credit: 'http://www.flickr.com/photos/boston_public_library/6082750550/', player: 'Johnny Pesky', first_year: '1871', last_year: '1875'
  add id: 'bos', name: 'Boston Red Sox', active: true, img: 'peskyjo01.jpg', img_credit: 'http://www.flickr.com/photos/boston_public_library/6082750550/', player: 'Johnny Pesky', first_year: '1901'
  add id: 'bra', name: 'Brooklyn Atlantics', img: 'peskyjo01.jpg', img_credit: 'http://www.flickr.com/photos/boston_public_library/6082750550/', player: 'Johnny Pesky', first_year: '1872', last_year: '1875'
  add id: 'brd', name: 'Boston Reds', img: 'peskyjo01.jpg', img_credit: 'http://www.flickr.com/photos/boston_public_library/6082750550/', player: 'Johnny Pesky', first_year: '1884', last_year: '1884'
  add id: 'brg', name: 'Brooklyn Gladiators', img: 'peskyjo01.jpg', img_credit: 'http://www.flickr.com/photos/boston_public_library/6082750550/', player: 'Johnny Pesky', first_year: '1890', last_year: '1890'
  add id: 'brs', name: 'Boston Reds', img: 'peskyjo01.jpg', img_credit: 'http://www.flickr.com/photos/boston_public_library/6082750550/', player: 'Johnny Pesky', first_year: '1890', last_year: '1891'
  add id: 'btt', name: 'Brooklyn Tip-Tops', img: 'peskyjo01.jpg', img_credit: 'http://www.flickr.com/photos/boston_public_library/6082750550/', player: 'Johnny Pesky', first_year: '1914', last_year: '1915'
  add id: 'buf', name: 'Buffalo Bisons', img: 'peskyjo01.jpg', img_credit: 'http://www.flickr.com/photos/boston_public_library/6082750550/', player: 'Johnny Pesky', first_year: '1879', last_year: '1885'
  add id: 'bww', name: 'Brooklyn Ward’s Wonders', img: 'peskyjo01.jpg', img_credit: 'http://www.flickr.com/photos/boston_public_library/6082750550/', player: 'Johnny Pesky', first_year: '1890', last_year: '1890'
  add id: 'cbk', name: 'Columbus Buckeyes', img: 'peskyjo01.jpg', img_credit: 'http://www.flickr.com/photos/boston_public_library/6082750550/', player: 'Johnny Pesky', first_year: '1883', last_year: '1884'
  add id: 'cbl', name: 'Cleveland Blues', img: 'peskyjo01.jpg', img_credit: 'http://www.flickr.com/photos/boston_public_library/6082750550/', player: 'Johnny Pesky', first_year: '1879', last_year: '1884'
  add id: 'cen', name: 'Philadelphia Centennials', img: 'peskyjo01.jpg', img_credit: 'http://www.flickr.com/photos/boston_public_library/6082750550/', player: 'Johnny Pesky', first_year: '1875', last_year: '1875'
  add id: 'cfc', name: 'Cleveland Forest Citys', img: 'peskyjo01.jpg', img_credit: 'http://www.flickr.com/photos/boston_public_library/6082750550/', player: 'Johnny Pesky', first_year: '1871', last_year: '1872'
  add id: 'chc', name: 'Chicago Cubs', active: true, img: 'peskyjo01.jpg', img_credit: 'http://www.flickr.com/photos/boston_public_library/6082750550/', player: 'Johnny Pesky', first_year: '1876'
  add id: 'chh', name: 'Chicago Whales', img: 'peskyjo01.jpg', img_credit: 'http://www.flickr.com/photos/boston_public_library/6082750550/', player: 'Johnny Pesky', first_year: '1914', last_year: '1915'
  add id: 'chp', name: 'Chicago Pirates', img: 'peskyjo01.jpg', img_credit: 'http://www.flickr.com/photos/boston_public_library/6082750550/', player: 'Johnny Pesky', first_year: '1890', last_year: '1890'
  add id: 'chw', name: 'Chicago White Sox', active: true, img: 'peskyjo01.jpg', img_credit: 'http://www.flickr.com/photos/boston_public_library/6082750550/', player: 'Johnny Pesky', first_year: '1901'
  add id: 'cin', name: 'Cincinnati Reds', active: true, img: 'peskyjo01.jpg', img_credit: 'http://www.flickr.com/photos/boston_public_library/6082750550/', player: 'Johnny Pesky', first_year: '1882'
  add id: 'ckk', name: 'Cincinnati Kelly’s Killers', img: 'peskyjo01.jpg', img_credit: 'http://www.flickr.com/photos/boston_public_library/6082750550/', player: 'Johnny Pesky', first_year: '1891', last_year: '1891'
  add id: 'cle', name: 'Cleveland Indians', active: true, img: 'peskyjo01.jpg', img_credit: 'http://www.flickr.com/photos/boston_public_library/6082750550/', player: 'Johnny Pesky', first_year: '1901'
  add id: 'cli', name: 'Cleveland Infants', img: 'peskyjo01.jpg', img_credit: 'http://www.flickr.com/photos/boston_public_library/6082750550/', player: 'Johnny Pesky', first_year: '1890', last_year: '1890'
  add id: 'cls', name: 'Columbus Solons', img: 'peskyjo01.jpg', img_credit: 'http://www.flickr.com/photos/boston_public_library/6082750550/', player: 'Johnny Pesky', first_year: '1889', last_year: '1891'
  add id: 'clv', name: 'Cleveland Spiders', img: 'peskyjo01.jpg', img_credit: 'http://www.flickr.com/photos/boston_public_library/6082750550/', player: 'Johnny Pesky', first_year: '1887', last_year: '1899'
  add id: 'cna', name: 'Chicago White Stockings', img: 'peskyjo01.jpg', img_credit: 'http://www.flickr.com/photos/boston_public_library/6082750550/', player: 'Johnny Pesky', first_year: '1871', last_year: '1875'
  add id: 'cnr', name: 'Cincinnati Reds', img: 'peskyjo01.jpg', img_credit: 'http://www.flickr.com/photos/boston_public_library/6082750550/', player: 'Johnny Pesky', first_year: '1876', last_year: '1880'
  add id: 'col', name: 'Colorado Rockies', active: true, img: 'peskyjo01.jpg', img_credit: 'http://www.flickr.com/photos/boston_public_library/6082750550/', player: 'Johnny Pesky', first_year: '1993'
  add id: 'cor', name: 'Cincinnati Outlaw Reds', img: 'peskyjo01.jpg', img_credit: 'http://www.flickr.com/photos/boston_public_library/6082750550/', player: 'Johnny Pesky', first_year: '1884', last_year: '1884'
  add id: 'cpi', name: 'Chicago/Pittsburgh (Union League)', img: 'peskyjo01.jpg', img_credit: 'http://www.flickr.com/photos/boston_public_library/6082750550/', player: 'Johnny Pesky', first_year: '1884', last_year: '1884'
  add id: 'det', name: 'Detroit Tigers', active: true, img: 'peskyjo01.jpg', img_credit: 'http://www.flickr.com/photos/boston_public_library/6082750550/', player: 'Johnny Pesky', first_year: '1901'
  add id: 'dtn', name: 'Detroit Wolverines', img: 'peskyjo01.jpg', img_credit: 'http://www.flickr.com/photos/boston_public_library/6082750550/', player: 'Johnny Pesky', first_year: '1881', last_year: '1888'
  add id: 'eck', name: 'Brooklyn Eckfords', img: 'peskyjo01.jpg', img_credit: 'http://www.flickr.com/photos/boston_public_library/6082750550/', player: 'Johnny Pesky', first_year: '1872', last_year: '1872'
  add id: 'fla', name: 'Miami Marlins', active: true, img: 'peskyjo01.jpg', img_credit: 'http://www.flickr.com/photos/boston_public_library/6082750550/', player: 'Johnny Pesky', first_year: '1993'
  add id: 'har', name: 'Hartford Dark Blues', img: 'peskyjo01.jpg', img_credit: 'http://www.flickr.com/photos/boston_public_library/6082750550/', player: 'Johnny Pesky', first_year: '1876', last_year: '1877'
  add id: 'hna', name: 'Hartford Dark Blues', img: 'peskyjo01.jpg', img_credit: 'http://www.flickr.com/photos/boston_public_library/6082750550/', player: 'Johnny Pesky', first_year: '1874', last_year: '1875'
  add id: 'hou', name: 'Houston Astros', active: true, img: 'peskyjo01.jpg', img_credit: 'http://www.flickr.com/photos/boston_public_library/6082750550/', player: 'Johnny Pesky', first_year: '1962'
  add id: 'ibl', name: 'Indianapolis Blues', img: 'peskyjo01.jpg', img_credit: 'http://www.flickr.com/photos/boston_public_library/6082750550/', player: 'Johnny Pesky', first_year: '1878', last_year: '1878'
  add id: 'iho', name: 'Indianapolis Hoosiers', img: 'peskyjo01.jpg', img_credit: 'http://www.flickr.com/photos/boston_public_library/6082750550/', player: 'Johnny Pesky', first_year: '1884', last_year: '1884'
  add id: 'ind', name: 'Indianapolis Hoosiers', img: 'peskyjo01.jpg', img_credit: 'http://www.flickr.com/photos/boston_public_library/6082750550/', player: 'Johnny Pesky', first_year: '1887', last_year: '1889'
  add id: 'kcc', name: 'Kansas City Cowboys', img: 'peskyjo01.jpg', img_credit: 'http://www.flickr.com/photos/boston_public_library/6082750550/', player: 'Johnny Pesky', first_year: '1888', last_year: '1889'
  add id: 'kcn', name: 'Kansas City Cowboys', img: 'peskyjo01.jpg', img_credit: 'http://www.flickr.com/photos/boston_public_library/6082750550/', player: 'Johnny Pesky', first_year: '1886', last_year: '1886'
  add id: 'kcp', name: 'Kansas City Packers', img: 'peskyjo01.jpg', img_credit: 'http://www.flickr.com/photos/boston_public_library/6082750550/', player: 'Johnny Pesky', first_year: '1914', last_year: '1915'
  add id: 'kcr', name: 'Kansas City Royals', active: true, img: 'peskyjo01.jpg', img_credit: 'http://www.flickr.com/photos/boston_public_library/6082750550/', player: 'Johnny Pesky', first_year: '1969'
  add id: 'kcu', name: 'Kansas City Cowboys', img: 'peskyjo01.jpg', img_credit: 'http://www.flickr.com/photos/boston_public_library/6082750550/', player: 'Johnny Pesky', first_year: '1884', last_year: '1884'
  add id: 'kek', name: 'Fort Wayne Kekiongas', img: 'peskyjo01.jpg', img_credit: 'http://www.flickr.com/photos/boston_public_library/6082750550/', player: 'Johnny Pesky', first_year: '1871', last_year: '1871'
  add id: 'lad', name: 'Los Angeles Dodgers', active: true, img: 'peskyjo01.jpg', img_credit: 'http://www.flickr.com/photos/boston_public_library/6082750550/', player: 'Johnny Pesky', first_year: '1884'
  add id: 'lgr', name: 'Louisville Grays', img: 'peskyjo01.jpg', img_credit: 'http://www.flickr.com/photos/boston_public_library/6082750550/', player: 'Johnny Pesky', first_year: '1876', last_year: '1877'
  add id: 'lou', name: 'Louisville Colonels', img: 'peskyjo01.jpg', img_credit: 'http://www.flickr.com/photos/boston_public_library/6082750550/', player: 'Johnny Pesky', first_year: '1882', last_year: '1899'
  add id: 'man', name: 'Middletown Mansfields', img: 'peskyjo01.jpg', img_credit: 'http://www.flickr.com/photos/boston_public_library/6082750550/', player: 'Johnny Pesky', first_year: '1872', last_year: '1872'
  add id: 'mar', name: 'Baltimore Marylands', img: 'peskyjo01.jpg', img_credit: 'http://www.flickr.com/photos/boston_public_library/6082750550/', player: 'Johnny Pesky', first_year: '1873', last_year: '1873'
  add id: 'mil', name: 'Milwaukee Brewers', active: true, img: 'peskyjo01.jpg', img_credit: 'http://www.flickr.com/photos/boston_public_library/6082750550/', player: 'Johnny Pesky', first_year: '1969'
  add id: 'min', name: 'Minnesota Twins', active: true, img: 'peskyjo01.jpg', img_credit: 'http://www.flickr.com/photos/boston_public_library/6082750550/', player: 'Johnny Pesky', first_year: '1901'
  add id: 'mla', name: 'Milwaukee Brewers', img: 'peskyjo01.jpg', img_credit: 'http://www.flickr.com/photos/boston_public_library/6082750550/', player: 'Johnny Pesky', first_year: '1891', last_year: '1891'
  add id: 'mlg', name: 'Milwaukee Grays', img: 'peskyjo01.jpg', img_credit: 'http://www.flickr.com/photos/boston_public_library/6082750550/', player: 'Johnny Pesky', first_year: '1878', last_year: '1878'
  add id: 'mlu', name: 'Milwaukee Brewers', img: 'peskyjo01.jpg', img_credit: 'http://www.flickr.com/photos/boston_public_library/6082750550/', player: 'Johnny Pesky', first_year: '1884', last_year: '1884'
  add id: 'nat', name: 'Washington Nationals', img: 'peskyjo01.jpg', img_credit: 'http://www.flickr.com/photos/boston_public_library/6082750550/', player: 'Johnny Pesky', first_year: '1872', last_year: '1872'
  add id: 'new', name: 'Newark Pepper', img: 'peskyjo01.jpg', img_credit: 'http://www.flickr.com/photos/boston_public_library/6082750550/', player: 'Johnny Pesky', first_year: '1914', last_year: '1915'
  add id: 'nhv', name: 'New Haven Elm Citys', img: 'peskyjo01.jpg', img_credit: 'http://www.flickr.com/photos/boston_public_library/6082750550/', player: 'Johnny Pesky', first_year: '1875', last_year: '1875'
  add id: 'nna', name: 'New York Mutuals', img: 'peskyjo01.jpg', img_credit: 'http://www.flickr.com/photos/boston_public_library/6082750550/', player: 'Johnny Pesky', first_year: '1871', last_year: '1875'
  add id: 'nyi', name: 'New York Giants', img: 'peskyjo01.jpg', img_credit: 'http://www.flickr.com/photos/boston_public_library/6082750550/', player: 'Johnny Pesky', first_year: '1890', last_year: '1890'
  add id: 'nym', name: 'New York Mets', active: true, img: 'peskyjo01.jpg', img_credit: 'http://www.flickr.com/photos/boston_public_library/6082750550/', player: 'Johnny Pesky', first_year: '1962'
  add id: 'nyp', name: 'New York Metropolitans', img: 'peskyjo01.jpg', img_credit: 'http://www.flickr.com/photos/boston_public_library/6082750550/', player: 'Johnny Pesky', first_year: '1883', last_year: '1887'
  add id: 'nyu', name: 'New York Mutuals', img: 'peskyjo01.jpg', img_credit: 'http://www.flickr.com/photos/boston_public_library/6082750550/', player: 'Johnny Pesky', first_year: '1876', last_year: '1876'
  add id: 'nyy', name: 'New York Yankees', active: true, img: 'dickebi01.jpg', img_credit: 'http://www.flickr.com/photos/boston_public_library/5935063550/', player: 'Bill Dickey', first_year: '1901'
  add id: 'oak', name: 'Oakland Athletics', active: true, img: 'peskyjo01.jpg', img_credit: 'http://www.flickr.com/photos/boston_public_library/6082750550/', player: 'Johnny Pesky', first_year: '1901'
  add id: 'oly', name: 'Washington Olympics', img: 'peskyjo01.jpg', img_credit: 'http://www.flickr.com/photos/boston_public_library/6082750550/', player: 'Johnny Pesky', first_year: '1871', last_year: '1872'
  add id: 'pbb', name: 'Pittsburgh Burghers', img: 'peskyjo01.jpg', img_credit: 'http://www.flickr.com/photos/boston_public_library/6082750550/', player: 'Johnny Pesky', first_year: '1890', last_year: '1890'
  add id: 'pbs', name: 'Pittsburgh Rebels', img: 'peskyjo01.jpg', img_credit: 'http://www.flickr.com/photos/boston_public_library/6082750550/', player: 'Johnny Pesky', first_year: '1914', last_year: '1915'
  add id: 'pha', name: 'Philadelphia Athletics', img: 'peskyjo01.jpg', img_credit: 'http://www.flickr.com/photos/boston_public_library/6082750550/', player: 'Johnny Pesky', first_year: '1882', last_year: '1890'
  add id: 'phi', name: 'Philadelphia Phillies', active: true, img: 'peskyjo01.jpg', img_credit: 'http://www.flickr.com/photos/boston_public_library/6082750550/', player: 'Johnny Pesky', first_year: '1883'
  add id: 'phk', name: 'Philadelphia Keystones', img: 'peskyjo01.jpg', img_credit: 'http://www.flickr.com/photos/boston_public_library/6082750550/', player: 'Johnny Pesky', first_year: '1884', last_year: '1884'
  add id: 'phq', name: 'Philadelphia Athletics', img: 'peskyjo01.jpg', img_credit: 'http://www.flickr.com/photos/boston_public_library/6082750550/', player: 'Johnny Pesky', first_year: '1890', last_year: '1891'
  add id: 'pit', name: 'Pittsburgh Pirates', active: true, img: 'peskyjo01.jpg', img_credit: 'http://www.flickr.com/photos/boston_public_library/6082750550/', player: 'Johnny Pesky', first_year: '1882'
  add id: 'pna', name: 'Philadelphia Athletics', img: 'peskyjo01.jpg', img_credit: 'http://www.flickr.com/photos/boston_public_library/6082750550/', player: 'Johnny Pesky', first_year: '1871', last_year: '1875'
  add id: 'pro', name: 'Providence Grays', img: 'peskyjo01.jpg', img_credit: 'http://www.flickr.com/photos/boston_public_library/6082750550/', player: 'Johnny Pesky', first_year: '1878', last_year: '1885'
  add id: 'pws', name: 'Philadelphia White Stockings', img: 'peskyjo01.jpg', img_credit: 'http://www.flickr.com/photos/boston_public_library/6082750550/', player: 'Johnny Pesky', first_year: '1873', last_year: '1875'
  add id: 'res', name: 'Elizabeth Resolutes', img: 'peskyjo01.jpg', img_credit: 'http://www.flickr.com/photos/boston_public_library/6082750550/', player: 'Johnny Pesky', first_year: '1873', last_year: '1873'
  add id: 'ric', name: 'Richmond Virginians', img: 'peskyjo01.jpg', img_credit: 'http://www.flickr.com/photos/boston_public_library/6082750550/', player: 'Johnny Pesky', first_year: '1884', last_year: '1884'
  add id: 'roc', name: 'Rochester Broncos', img: 'peskyjo01.jpg', img_credit: 'http://www.flickr.com/photos/boston_public_library/6082750550/', player: 'Johnny Pesky', first_year: '1890', last_year: '1890'
  add id: 'rok', name: 'Rockford Forest Citys', img: 'peskyjo01.jpg', img_credit: 'http://www.flickr.com/photos/boston_public_library/6082750550/', player: 'Johnny Pesky', first_year: '1871', last_year: '1871'
  add id: 'sbs', name: 'St. Louis Brown Stockings', img: 'peskyjo01.jpg', img_credit: 'http://www.flickr.com/photos/boston_public_library/6082750550/', player: 'Johnny Pesky', first_year: '1876', last_year: '1877'
  add id: 'sdp', name: 'San Diego Padres', active: true, img: 'peskyjo01.jpg', img_credit: 'http://www.flickr.com/photos/boston_public_library/6082750550/', player: 'Johnny Pesky', first_year: '1969'
  add id: 'sea', name: 'Seattle Mariners', active: true, img: 'peskyjo01.jpg', img_credit: 'http://www.flickr.com/photos/boston_public_library/6082750550/', player: 'Johnny Pesky', first_year: '1977'
  add id: 'sfg', name: 'San Francisco Giants', active: true, img: 'peskyjo01.jpg', img_credit: 'http://www.flickr.com/photos/boston_public_library/6082750550/', player: 'Johnny Pesky', first_year: '1883'
  add id: 'sli', name: 'St. Louis Terriers', img: 'peskyjo01.jpg', img_credit: 'http://www.flickr.com/photos/boston_public_library/6082750550/', player: 'Johnny Pesky', first_year: '1914', last_year: '1915'
  add id: 'slm', name: 'St. Louis Maroons', img: 'peskyjo01.jpg', img_credit: 'http://www.flickr.com/photos/boston_public_library/6082750550/', player: 'Johnny Pesky', first_year: '1884', last_year: '1886'
  add id: 'slr', name: 'St. Louis Red Stockings', img: 'peskyjo01.jpg', img_credit: 'http://www.flickr.com/photos/boston_public_library/6082750550/', player: 'Johnny Pesky', first_year: '1875', last_year: '1875'
  add id: 'sna', name: 'St. Louis Brown Stockings', img: 'peskyjo01.jpg', img_credit: 'http://www.flickr.com/photos/boston_public_library/6082750550/', player: 'Johnny Pesky', first_year: '1875', last_year: '1875'
  add id: 'stl', name: 'St. Louis Cardinals', active: true, img: 'peskyjo01.jpg', img_credit: 'http://www.flickr.com/photos/boston_public_library/6082750550/', player: 'Johnny Pesky', first_year: '1882'
  add id: 'stp', name: 'St. Paul Apostles', img: 'peskyjo01.jpg', img_credit: 'http://www.flickr.com/photos/boston_public_library/6082750550/', player: 'Johnny Pesky', first_year: '1884', last_year: '1884'
  add id: 'syr', name: 'Syracuse Stars', img: 'peskyjo01.jpg', img_credit: 'http://www.flickr.com/photos/boston_public_library/6082750550/', player: 'Johnny Pesky', first_year: '1879', last_year: '1879'
  add id: 'sys', name: 'Syracuse Stars', img: 'peskyjo01.jpg', img_credit: 'http://www.flickr.com/photos/boston_public_library/6082750550/', player: 'Johnny Pesky', first_year: '1890', last_year: '1890'
  add id: 'tbd', name: 'Tampa Bay Rays', active: true, img: 'peskyjo01.jpg', img_credit: 'http://www.flickr.com/photos/boston_public_library/6082750550/', player: 'Johnny Pesky', first_year: '1998'
  add id: 'tex', name: 'Texas Rangers', active: true, img: 'peskyjo01.jpg', img_credit: 'http://www.flickr.com/photos/boston_public_library/6082750550/', player: 'Johnny Pesky', first_year: '1961'
  add id: 'tlm', name: 'Toledo Maumees', img: 'peskyjo01.jpg', img_credit: 'http://www.flickr.com/photos/boston_public_library/6082750550/', player: 'Johnny Pesky', first_year: '1890', last_year: '1890'
  add id: 'tol', name: 'Toledo Blue Stockings', img: 'peskyjo01.jpg', img_credit: 'http://www.flickr.com/photos/boston_public_library/6082750550/', player: 'Johnny Pesky', first_year: '1884', last_year: '1884'
  add id: 'tor', name: 'Toronto Blue Jays', active: true, img: 'peskyjo01.jpg', img_credit: 'http://www.flickr.com/photos/boston_public_library/6082750550/', player: 'Johnny Pesky', first_year: '1977'
  add id: 'tro', name: 'Troy Haymakers', img: 'peskyjo01.jpg', img_credit: 'http://www.flickr.com/photos/boston_public_library/6082750550/', player: 'Johnny Pesky', first_year: '1871', last_year: '1872'
  add id: 'trt', name: 'Troy Trojans', img: 'peskyjo01.jpg', img_credit: 'http://www.flickr.com/photos/boston_public_library/6082750550/', player: 'Johnny Pesky', first_year: '1879', last_year: '1882'
  add id: 'was', name: 'Washington Senators', img: 'peskyjo01.jpg', img_credit: 'http://www.flickr.com/photos/boston_public_library/6082750550/', player: 'Johnny Pesky', first_year: '1891', last_year: '1899'
  add id: 'wbl', name: 'Washington Blue Legs', img: 'peskyjo01.jpg', img_credit: 'http://www.flickr.com/photos/boston_public_library/6082750550/', player: 'Johnny Pesky', first_year: '1873', last_year: '1873'
  add id: 'wes', name: 'Keokuk Westerns', img: 'peskyjo01.jpg', img_credit: 'http://www.flickr.com/photos/boston_public_library/6082750550/', player: 'Johnny Pesky', first_year: '1875', last_year: '1875'
  add id: 'wil', name: 'Wilmington Quicksteps', img: 'peskyjo01.jpg', img_credit: 'http://www.flickr.com/photos/boston_public_library/6082750550/', player: 'Johnny Pesky', first_year: '1884', last_year: '1884'
  add id: 'wna', name: 'Washington Nationals', img: 'peskyjo01.jpg', img_credit: 'http://www.flickr.com/photos/boston_public_library/6082750550/', player: 'Johnny Pesky', first_year: '1884', last_year: '1884'
  add id: 'wnl', name: 'Washington Nationals', img: 'peskyjo01.jpg', img_credit: 'http://www.flickr.com/photos/boston_public_library/6082750550/', player: 'Johnny Pesky', first_year: '1886', last_year: '1889'
  add id: 'wnt', name: 'Washington Nationals', img: 'peskyjo01.jpg', img_credit: 'http://www.flickr.com/photos/boston_public_library/6082750550/', player: 'Johnny Pesky', first_year: '1875', last_year: '1875'
  add id: 'wor', name: 'Worcester Ruby Legs', img: 'peskyjo01.jpg', img_credit: 'http://www.flickr.com/photos/boston_public_library/6082750550/', player: 'Johnny Pesky', first_year: '1880', last_year: '1882'
  add id: 'wsn', name: 'Washington Nationals', active: true, img: 'peskyjo01.jpg', img_credit: 'http://www.flickr.com/photos/boston_public_library/6082750550/', player: 'Johnny Pesky', first_year: '1969'
  add id: 'wst', name: 'Washington Statesmen', img: 'peskyjo01.jpg', img_credit: 'http://www.flickr.com/photos/boston_public_library/6082750550/', player: 'Johnny Pesky', first_year: '1884', last_year: '1884'

end
