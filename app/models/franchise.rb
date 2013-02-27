# -*- encoding: utf-8 -*-

class Franchise < ActiveHash::Base
  include ActiveHash::Associations
  
  fields :name, :img, :img_credit, :player, :active
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
  
  def top_player_for_position(position)
    players_for_position(position).first
  end
  
  add id: 'alt', name: 'Altoona Mountain City', img: 'peskyjo01.jpg', img_credit: 'http://www.flickr.com/photos/boston_public_library/6082750550/', player: 'Johnny Pesky'
  add id: 'ana', name: 'Los Angeles Angels of Anaheim', active: true, img: 'peskyjo01.jpg', img_credit: 'http://www.flickr.com/photos/boston_public_library/6082750550/', player: 'Johnny Pesky'
  add id: 'ari', name: 'Arizona Diamondbacks', active: true, img: 'peskyjo01.jpg', img_credit: 'http://www.flickr.com/photos/boston_public_library/6082750550/', player: 'Johnny Pesky'
  add id: 'ath', name: 'Philadelphia Athletics', img: 'peskyjo01.jpg', img_credit: 'http://www.flickr.com/photos/boston_public_library/6082750550/', player: 'Johnny Pesky'
  add id: 'atl', name: 'Atlanta Braves', active: true, img: 'peskyjo01.jpg', img_credit: 'http://www.flickr.com/photos/boston_public_library/6082750550/', player: 'Johnny Pesky'
  add id: 'bal', name: 'Baltimore Orioles', active: true, img: 'peskyjo01.jpg', img_credit: 'http://www.flickr.com/photos/boston_public_library/6082750550/', player: 'Johnny Pesky'
  add id: 'bfb', name: 'Buffalo Bisons', img: 'peskyjo01.jpg', img_credit: 'http://www.flickr.com/photos/boston_public_library/6082750550/', player: 'Johnny Pesky'
  add id: 'bfl', name: 'Buffalo Bisons', img: 'peskyjo01.jpg', img_credit: 'http://www.flickr.com/photos/boston_public_library/6082750550/', player: 'Johnny Pesky'
  add id: 'blc', name: 'Baltimore Canaries', img: 'peskyjo01.jpg', img_credit: 'http://www.flickr.com/photos/boston_public_library/6082750550/', player: 'Johnny Pesky'
  add id: 'blo', name: 'Baltimore Orioles', img: 'peskyjo01.jpg', img_credit: 'http://www.flickr.com/photos/boston_public_library/6082750550/', player: 'Johnny Pesky'
  add id: 'blt', name: 'Baltimore Terrapins', img: 'peskyjo01.jpg', img_credit: 'http://www.flickr.com/photos/boston_public_library/6082750550/', player: 'Johnny Pesky'
  add id: 'blu', name: 'Baltimore Monumentals', img: 'peskyjo01.jpg', img_credit: 'http://www.flickr.com/photos/boston_public_library/6082750550/', player: 'Johnny Pesky'
  add id: 'bna', name: 'Boston Red Stockings', img: 'peskyjo01.jpg', img_credit: 'http://www.flickr.com/photos/boston_public_library/6082750550/', player: 'Johnny Pesky'
  add id: 'bos', name: 'Boston Red Sox', active: true, img: 'peskyjo01.jpg', img_credit: 'http://www.flickr.com/photos/boston_public_library/6082750550/', player: 'Johnny Pesky'
  add id: 'bra', name: 'Brooklyn Atlantics', img: 'peskyjo01.jpg', img_credit: 'http://www.flickr.com/photos/boston_public_library/6082750550/', player: 'Johnny Pesky'
  add id: 'brd', name: 'Boston Reds', img: 'peskyjo01.jpg', img_credit: 'http://www.flickr.com/photos/boston_public_library/6082750550/', player: 'Johnny Pesky'
  add id: 'brg', name: 'Brooklyn Gladiators', img: 'peskyjo01.jpg', img_credit: 'http://www.flickr.com/photos/boston_public_library/6082750550/', player: 'Johnny Pesky'
  add id: 'brs', name: 'Boston Reds', img: 'peskyjo01.jpg', img_credit: 'http://www.flickr.com/photos/boston_public_library/6082750550/', player: 'Johnny Pesky'
  add id: 'btt', name: 'Brooklyn Tip-Tops', img: 'peskyjo01.jpg', img_credit: 'http://www.flickr.com/photos/boston_public_library/6082750550/', player: 'Johnny Pesky'
  add id: 'buf', name: 'Buffalo Bisons', img: 'peskyjo01.jpg', img_credit: 'http://www.flickr.com/photos/boston_public_library/6082750550/', player: 'Johnny Pesky'
  add id: 'bww', name: 'Brooklyn Ward’s Wonders', img: 'peskyjo01.jpg', img_credit: 'http://www.flickr.com/photos/boston_public_library/6082750550/', player: 'Johnny Pesky'
  add id: 'cbk', name: 'Columbus Buckeyes', img: 'peskyjo01.jpg', img_credit: 'http://www.flickr.com/photos/boston_public_library/6082750550/', player: 'Johnny Pesky'
  add id: 'cbl', name: 'Cleveland Blues', img: 'peskyjo01.jpg', img_credit: 'http://www.flickr.com/photos/boston_public_library/6082750550/', player: 'Johnny Pesky'
  add id: 'cen', name: 'Philadelphia Centennials', img: 'peskyjo01.jpg', img_credit: 'http://www.flickr.com/photos/boston_public_library/6082750550/', player: 'Johnny Pesky'
  add id: 'cfc', name: 'Cleveland Forest Citys', img: 'peskyjo01.jpg', img_credit: 'http://www.flickr.com/photos/boston_public_library/6082750550/', player: 'Johnny Pesky'
  add id: 'chc', name: 'Chicago Cubs', active: true, img: 'peskyjo01.jpg', img_credit: 'http://www.flickr.com/photos/boston_public_library/6082750550/', player: 'Johnny Pesky'
  add id: 'chh', name: 'Chicago Whales', img: 'peskyjo01.jpg', img_credit: 'http://www.flickr.com/photos/boston_public_library/6082750550/', player: 'Johnny Pesky'
  add id: 'chp', name: 'Chicago Pirates', img: 'peskyjo01.jpg', img_credit: 'http://www.flickr.com/photos/boston_public_library/6082750550/', player: 'Johnny Pesky'
  add id: 'chw', name: 'Chicago White Sox', active: true, img: 'peskyjo01.jpg', img_credit: 'http://www.flickr.com/photos/boston_public_library/6082750550/', player: 'Johnny Pesky'
  add id: 'cin', name: 'Cincinnati Reds', active: true, img: 'peskyjo01.jpg', img_credit: 'http://www.flickr.com/photos/boston_public_library/6082750550/', player: 'Johnny Pesky'
  add id: 'ckk', name: 'Cincinnati Kelly’s Killers', img: 'peskyjo01.jpg', img_credit: 'http://www.flickr.com/photos/boston_public_library/6082750550/', player: 'Johnny Pesky'
  add id: 'cle', name: 'Cleveland Indians', active: true, img: 'peskyjo01.jpg', img_credit: 'http://www.flickr.com/photos/boston_public_library/6082750550/', player: 'Johnny Pesky'
  add id: 'cli', name: 'Cleveland Infants', img: 'peskyjo01.jpg', img_credit: 'http://www.flickr.com/photos/boston_public_library/6082750550/', player: 'Johnny Pesky'
  add id: 'cls', name: 'Columbus Solons', img: 'peskyjo01.jpg', img_credit: 'http://www.flickr.com/photos/boston_public_library/6082750550/', player: 'Johnny Pesky'
  add id: 'clv', name: 'Cleveland Spiders', img: 'peskyjo01.jpg', img_credit: 'http://www.flickr.com/photos/boston_public_library/6082750550/', player: 'Johnny Pesky'
  add id: 'cna', name: 'Chicago White Stockings', img: 'peskyjo01.jpg', img_credit: 'http://www.flickr.com/photos/boston_public_library/6082750550/', player: 'Johnny Pesky'
  add id: 'cnr', name: 'Cincinnati Reds', img: 'peskyjo01.jpg', img_credit: 'http://www.flickr.com/photos/boston_public_library/6082750550/', player: 'Johnny Pesky'
  add id: 'col', name: 'Colorado Rockies', active: true, img: 'peskyjo01.jpg', img_credit: 'http://www.flickr.com/photos/boston_public_library/6082750550/', player: 'Johnny Pesky'
  add id: 'cor', name: 'Cincinnati Outlaw Reds', img: 'peskyjo01.jpg', img_credit: 'http://www.flickr.com/photos/boston_public_library/6082750550/', player: 'Johnny Pesky'
  add id: 'cpi', name: 'Chicago/Pittsburgh (Union League)', img: 'peskyjo01.jpg', img_credit: 'http://www.flickr.com/photos/boston_public_library/6082750550/', player: 'Johnny Pesky'
  add id: 'det', name: 'Detroit Tigers', active: true, img: 'peskyjo01.jpg', img_credit: 'http://www.flickr.com/photos/boston_public_library/6082750550/', player: 'Johnny Pesky'
  add id: 'dtn', name: 'Detroit Wolverines', img: 'peskyjo01.jpg', img_credit: 'http://www.flickr.com/photos/boston_public_library/6082750550/', player: 'Johnny Pesky'
  add id: 'eck', name: 'Brooklyn Eckfords', img: 'peskyjo01.jpg', img_credit: 'http://www.flickr.com/photos/boston_public_library/6082750550/', player: 'Johnny Pesky'
  add id: 'fla', name: 'Miami Marlins', active: true, img: 'peskyjo01.jpg', img_credit: 'http://www.flickr.com/photos/boston_public_library/6082750550/', player: 'Johnny Pesky'
  add id: 'har', name: 'Hartford Dark Blues', img: 'peskyjo01.jpg', img_credit: 'http://www.flickr.com/photos/boston_public_library/6082750550/', player: 'Johnny Pesky'
  add id: 'hna', name: 'Hartford Dark Blues', img: 'peskyjo01.jpg', img_credit: 'http://www.flickr.com/photos/boston_public_library/6082750550/', player: 'Johnny Pesky'
  add id: 'hou', name: 'Houston Astros', active: true, img: 'peskyjo01.jpg', img_credit: 'http://www.flickr.com/photos/boston_public_library/6082750550/', player: 'Johnny Pesky'
  add id: 'ibl', name: 'Indianapolis Blues', img: 'peskyjo01.jpg', img_credit: 'http://www.flickr.com/photos/boston_public_library/6082750550/', player: 'Johnny Pesky'
  add id: 'iho', name: 'Indianapolis Hoosiers', img: 'peskyjo01.jpg', img_credit: 'http://www.flickr.com/photos/boston_public_library/6082750550/', player: 'Johnny Pesky'
  add id: 'ind', name: 'Indianapolis Hoosiers', img: 'peskyjo01.jpg', img_credit: 'http://www.flickr.com/photos/boston_public_library/6082750550/', player: 'Johnny Pesky'
  add id: 'kcc', name: 'Kansas City Cowboys', img: 'peskyjo01.jpg', img_credit: 'http://www.flickr.com/photos/boston_public_library/6082750550/', player: 'Johnny Pesky'
  add id: 'kcn', name: 'Kansas City Cowboys', img: 'peskyjo01.jpg', img_credit: 'http://www.flickr.com/photos/boston_public_library/6082750550/', player: 'Johnny Pesky'
  add id: 'kcp', name: 'Kansas City Packers', img: 'peskyjo01.jpg', img_credit: 'http://www.flickr.com/photos/boston_public_library/6082750550/', player: 'Johnny Pesky'
  add id: 'kcr', name: 'Kansas City Royals', active: true, img: 'peskyjo01.jpg', img_credit: 'http://www.flickr.com/photos/boston_public_library/6082750550/', player: 'Johnny Pesky'
  add id: 'kcu', name: 'Kansas City Cowboys', img: 'peskyjo01.jpg', img_credit: 'http://www.flickr.com/photos/boston_public_library/6082750550/', player: 'Johnny Pesky'
  add id: 'kek', name: 'Fort Wayne Kekiongas', img: 'peskyjo01.jpg', img_credit: 'http://www.flickr.com/photos/boston_public_library/6082750550/', player: 'Johnny Pesky'
  add id: 'lad', name: 'Los Angeles Dodgers', active: true, img: 'peskyjo01.jpg', img_credit: 'http://www.flickr.com/photos/boston_public_library/6082750550/', player: 'Johnny Pesky'
  add id: 'lgr', name: 'Louisville Grays', img: 'peskyjo01.jpg', img_credit: 'http://www.flickr.com/photos/boston_public_library/6082750550/', player: 'Johnny Pesky'
  add id: 'lou', name: 'Louisville Colonels', img: 'peskyjo01.jpg', img_credit: 'http://www.flickr.com/photos/boston_public_library/6082750550/', player: 'Johnny Pesky'
  add id: 'man', name: 'Middletown Mansfields', img: 'peskyjo01.jpg', img_credit: 'http://www.flickr.com/photos/boston_public_library/6082750550/', player: 'Johnny Pesky'
  add id: 'mar', name: 'Baltimore Marylands', img: 'peskyjo01.jpg', img_credit: 'http://www.flickr.com/photos/boston_public_library/6082750550/', player: 'Johnny Pesky'
  add id: 'mil', name: 'Milwaukee Brewers', active: true, img: 'peskyjo01.jpg', img_credit: 'http://www.flickr.com/photos/boston_public_library/6082750550/', player: 'Johnny Pesky'
  add id: 'min', name: 'Minnesota Twins', active: true, img: 'peskyjo01.jpg', img_credit: 'http://www.flickr.com/photos/boston_public_library/6082750550/', player: 'Johnny Pesky'
  add id: 'mla', name: 'Milwaukee Brewers', img: 'peskyjo01.jpg', img_credit: 'http://www.flickr.com/photos/boston_public_library/6082750550/', player: 'Johnny Pesky'
  add id: 'mlg', name: 'Milwaukee Grays', img: 'peskyjo01.jpg', img_credit: 'http://www.flickr.com/photos/boston_public_library/6082750550/', player: 'Johnny Pesky'
  add id: 'mlu', name: 'Milwaukee Brewers', img: 'peskyjo01.jpg', img_credit: 'http://www.flickr.com/photos/boston_public_library/6082750550/', player: 'Johnny Pesky'
  add id: 'nat', name: 'Washington Nationals', img: 'peskyjo01.jpg', img_credit: 'http://www.flickr.com/photos/boston_public_library/6082750550/', player: 'Johnny Pesky'
  add id: 'new', name: 'Newark Pepper', img: 'peskyjo01.jpg', img_credit: 'http://www.flickr.com/photos/boston_public_library/6082750550/', player: 'Johnny Pesky'
  add id: 'nhv', name: 'New Haven Elm Citys', img: 'peskyjo01.jpg', img_credit: 'http://www.flickr.com/photos/boston_public_library/6082750550/', player: 'Johnny Pesky'
  add id: 'nna', name: 'New York Mutuals', img: 'peskyjo01.jpg', img_credit: 'http://www.flickr.com/photos/boston_public_library/6082750550/', player: 'Johnny Pesky'
  add id: 'nyi', name: 'New York Giants', img: 'peskyjo01.jpg', img_credit: 'http://www.flickr.com/photos/boston_public_library/6082750550/', player: 'Johnny Pesky'
  add id: 'nym', name: 'New York Mets', active: true, img: 'peskyjo01.jpg', img_credit: 'http://www.flickr.com/photos/boston_public_library/6082750550/', player: 'Johnny Pesky'
  add id: 'nyp', name: 'New York Metropolitans', img: 'peskyjo01.jpg', img_credit: 'http://www.flickr.com/photos/boston_public_library/6082750550/', player: 'Johnny Pesky'
  add id: 'nyu', name: 'New York Mutuals', img: 'peskyjo01.jpg', img_credit: 'http://www.flickr.com/photos/boston_public_library/6082750550/', player: 'Johnny Pesky'
  add id: 'nyy', name: 'New York Yankees', active: true, img: 'dickebi01.jpg', img_credit: 'http://www.flickr.com/photos/boston_public_library/5935063550/', player: 'Bill Dickey'
  add id: 'oak', name: 'Oakland Athletics', active: true, img: 'peskyjo01.jpg', img_credit: 'http://www.flickr.com/photos/boston_public_library/6082750550/', player: 'Johnny Pesky'
  add id: 'oly', name: 'Washington Olympics', img: 'peskyjo01.jpg', img_credit: 'http://www.flickr.com/photos/boston_public_library/6082750550/', player: 'Johnny Pesky'
  add id: 'pbb', name: 'Pittsburgh Burghers', img: 'peskyjo01.jpg', img_credit: 'http://www.flickr.com/photos/boston_public_library/6082750550/', player: 'Johnny Pesky'
  add id: 'pbs', name: 'Pittsburgh Rebels', img: 'peskyjo01.jpg', img_credit: 'http://www.flickr.com/photos/boston_public_library/6082750550/', player: 'Johnny Pesky'
  add id: 'pha', name: 'Philadelphia Athletics', img: 'peskyjo01.jpg', img_credit: 'http://www.flickr.com/photos/boston_public_library/6082750550/', player: 'Johnny Pesky'
  add id: 'phi', name: 'Philadelphia Phillies', active: true, img: 'peskyjo01.jpg', img_credit: 'http://www.flickr.com/photos/boston_public_library/6082750550/', player: 'Johnny Pesky'
  add id: 'phk', name: 'Philadelphia Keystones', img: 'peskyjo01.jpg', img_credit: 'http://www.flickr.com/photos/boston_public_library/6082750550/', player: 'Johnny Pesky'
  add id: 'phq', name: 'Philadelphia Athletics', img: 'peskyjo01.jpg', img_credit: 'http://www.flickr.com/photos/boston_public_library/6082750550/', player: 'Johnny Pesky'
  add id: 'pit', name: 'Pittsburgh Pirates', active: true, img: 'peskyjo01.jpg', img_credit: 'http://www.flickr.com/photos/boston_public_library/6082750550/', player: 'Johnny Pesky'
  add id: 'pna', name: 'Philadelphia Athletics', img: 'peskyjo01.jpg', img_credit: 'http://www.flickr.com/photos/boston_public_library/6082750550/', player: 'Johnny Pesky'
  add id: 'pro', name: 'Providence Grays', img: 'peskyjo01.jpg', img_credit: 'http://www.flickr.com/photos/boston_public_library/6082750550/', player: 'Johnny Pesky'
  add id: 'pws', name: 'Philadelphia White Stockings', img: 'peskyjo01.jpg', img_credit: 'http://www.flickr.com/photos/boston_public_library/6082750550/', player: 'Johnny Pesky'
  add id: 'res', name: 'Elizabeth Resolutes', img: 'peskyjo01.jpg', img_credit: 'http://www.flickr.com/photos/boston_public_library/6082750550/', player: 'Johnny Pesky'
  add id: 'ric', name: 'Richmond Virginians', img: 'peskyjo01.jpg', img_credit: 'http://www.flickr.com/photos/boston_public_library/6082750550/', player: 'Johnny Pesky'
  add id: 'roc', name: 'Rochester Broncos', img: 'peskyjo01.jpg', img_credit: 'http://www.flickr.com/photos/boston_public_library/6082750550/', player: 'Johnny Pesky'
  add id: 'rok', name: 'Rockford Forest Citys', img: 'peskyjo01.jpg', img_credit: 'http://www.flickr.com/photos/boston_public_library/6082750550/', player: 'Johnny Pesky'
  add id: 'sbs', name: 'St. Louis Brown Stockings', img: 'peskyjo01.jpg', img_credit: 'http://www.flickr.com/photos/boston_public_library/6082750550/', player: 'Johnny Pesky'
  add id: 'sdp', name: 'San Diego Padres', active: true, img: 'peskyjo01.jpg', img_credit: 'http://www.flickr.com/photos/boston_public_library/6082750550/', player: 'Johnny Pesky'
  add id: 'sea', name: 'Seattle Mariners', active: true, img: 'peskyjo01.jpg', img_credit: 'http://www.flickr.com/photos/boston_public_library/6082750550/', player: 'Johnny Pesky'
  add id: 'sfg', name: 'San Francisco Giants', active: true, img: 'peskyjo01.jpg', img_credit: 'http://www.flickr.com/photos/boston_public_library/6082750550/', player: 'Johnny Pesky'
  add id: 'sli', name: 'St. Louis Terriers', img: 'peskyjo01.jpg', img_credit: 'http://www.flickr.com/photos/boston_public_library/6082750550/', player: 'Johnny Pesky'
  add id: 'slm', name: 'St. Louis Maroons', img: 'peskyjo01.jpg', img_credit: 'http://www.flickr.com/photos/boston_public_library/6082750550/', player: 'Johnny Pesky'
  add id: 'slr', name: 'St. Louis Red Stockings', img: 'peskyjo01.jpg', img_credit: 'http://www.flickr.com/photos/boston_public_library/6082750550/', player: 'Johnny Pesky'
  add id: 'sna', name: 'St. Louis Brown Stockings', img: 'peskyjo01.jpg', img_credit: 'http://www.flickr.com/photos/boston_public_library/6082750550/', player: 'Johnny Pesky'
  add id: 'stl', name: 'St. Louis Cardinals', active: true, img: 'peskyjo01.jpg', img_credit: 'http://www.flickr.com/photos/boston_public_library/6082750550/', player: 'Johnny Pesky'
  add id: 'stp', name: 'St. Paul Apostles', img: 'peskyjo01.jpg', img_credit: 'http://www.flickr.com/photos/boston_public_library/6082750550/', player: 'Johnny Pesky'
  add id: 'syr', name: 'Syracuse Stars', img: 'peskyjo01.jpg', img_credit: 'http://www.flickr.com/photos/boston_public_library/6082750550/', player: 'Johnny Pesky'
  add id: 'sys', name: 'Syracuse Stars', img: 'peskyjo01.jpg', img_credit: 'http://www.flickr.com/photos/boston_public_library/6082750550/', player: 'Johnny Pesky'
  add id: 'tbd', name: 'Tampa Bay Rays', active: true, img: 'peskyjo01.jpg', img_credit: 'http://www.flickr.com/photos/boston_public_library/6082750550/', player: 'Johnny Pesky'
  add id: 'tex', name: 'Texas Rangers', active: true, img: 'peskyjo01.jpg', img_credit: 'http://www.flickr.com/photos/boston_public_library/6082750550/', player: 'Johnny Pesky'
  add id: 'tlm', name: 'Toledo Maumees', img: 'peskyjo01.jpg', img_credit: 'http://www.flickr.com/photos/boston_public_library/6082750550/', player: 'Johnny Pesky'
  add id: 'tol', name: 'Toledo Blue Stockings', img: 'peskyjo01.jpg', img_credit: 'http://www.flickr.com/photos/boston_public_library/6082750550/', player: 'Johnny Pesky'
  add id: 'tor', name: 'Toronto Blue Jays', active: true, img: 'peskyjo01.jpg', img_credit: 'http://www.flickr.com/photos/boston_public_library/6082750550/', player: 'Johnny Pesky'
  add id: 'tro', name: 'Troy Haymakers', img: 'peskyjo01.jpg', img_credit: 'http://www.flickr.com/photos/boston_public_library/6082750550/', player: 'Johnny Pesky'
  add id: 'trt', name: 'Troy Trojans', img: 'peskyjo01.jpg', img_credit: 'http://www.flickr.com/photos/boston_public_library/6082750550/', player: 'Johnny Pesky'
  add id: 'was', name: 'Washington Senators', img: 'peskyjo01.jpg', img_credit: 'http://www.flickr.com/photos/boston_public_library/6082750550/', player: 'Johnny Pesky'
  add id: 'wbl', name: 'Washington Blue Legs', img: 'peskyjo01.jpg', img_credit: 'http://www.flickr.com/photos/boston_public_library/6082750550/', player: 'Johnny Pesky'
  add id: 'wes', name: 'Keokuk Westerns', img: 'peskyjo01.jpg', img_credit: 'http://www.flickr.com/photos/boston_public_library/6082750550/', player: 'Johnny Pesky'
  add id: 'wil', name: 'Wilmington Quicksteps', img: 'peskyjo01.jpg', img_credit: 'http://www.flickr.com/photos/boston_public_library/6082750550/', player: 'Johnny Pesky'
  add id: 'wna', name: 'Washington Nationals', img: 'peskyjo01.jpg', img_credit: 'http://www.flickr.com/photos/boston_public_library/6082750550/', player: 'Johnny Pesky'
  add id: 'wnl', name: 'Washington Nationals', img: 'peskyjo01.jpg', img_credit: 'http://www.flickr.com/photos/boston_public_library/6082750550/', player: 'Johnny Pesky'
  add id: 'wnt', name: 'Washington Nationals', img: 'peskyjo01.jpg', img_credit: 'http://www.flickr.com/photos/boston_public_library/6082750550/', player: 'Johnny Pesky'
  add id: 'wor', name: 'Worcester Ruby Legs', img: 'peskyjo01.jpg', img_credit: 'http://www.flickr.com/photos/boston_public_library/6082750550/', player: 'Johnny Pesky'
  add id: 'wsn', name: 'Washington Nationals', active: true, img: 'peskyjo01.jpg', img_credit: 'http://www.flickr.com/photos/boston_public_library/6082750550/', player: 'Johnny Pesky'
  add id: 'wst', name: 'Washington Statesmen', img: 'peskyjo01.jpg', img_credit: 'http://www.flickr.com/photos/boston_public_library/6082750550/', player: 'Johnny Pesky'

end
