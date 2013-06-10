# -*- encoding: utf-8 -*-

class Franchise < ActiveHash::Base
  include ActiveHash::Associations
  
  fields :name, :img, :img_credit, :player, :active, :first_year, :last_year, :note, :color
  field :color, default: '#000000'
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

  add id: 'alt', name: 'Altoona Mountain City', first_year: '1884', last_year: '1884'
  add id: 'ana', name: 'Los Angeles Angels of Anaheim', active: true, img: 'troutmi01', img_credit: 'http://www.flickr.com/photos/keithallison/7458320456/', player: 'Mike Trout', first_year: '1961', note: 'Also played as Anaheim Angels, California Angels, and Los Angeles Angels.', color: '#CE1141'
  add id: 'ari', name: 'Arizona Diamondbacks', active: true, img: 'johnsra05', img_credit: 'http://en.wikipedia.org/wiki/File:Randy_Johnson_04.jpg', player: 'Randy Johnson', first_year: '1998', color: '#C51230'
  add id: 'ath', name: 'Philadelphia Athletics', first_year: '1876', last_year: '1876'
  add id: 'atl', name: 'Atlanta Braves', active: true, img: 'jonesch06', img_credit: 'http://www.flickr.com/photos/keithallison/3620680381/', player: 'Chipper Jones', first_year: '1876', note: 'Also played as Milwaukee Braves, Boston Braves, Boston Bees, Boston Rustlers, Boston Doves, Boston Beaneaters, and Boston Red Stockings.', color: '#01487E'
  add id: 'bal', name: 'Baltimore Orioles', active: true, img: 'wietema01', img_credit: 'http://www.flickr.com/photos/keithallison/5709564672/', player: 'Matt Wieters', first_year: '1901', note: 'Also played as St. Louis Browns and Milwaukee Brewers.', color: '#DF4601'
  add id: 'bfb', name: 'Buffalo Bisons', first_year: '1890', last_year: '1890'
  add id: 'bfl', name: 'Buffalo Bisons', first_year: '1914', last_year: '1915', note: 'Also played as Buffalo Blues and Buffalo Buffeds.'
  add id: 'blc', name: 'Baltimore Canaries', first_year: '1872', last_year: '1874'
  add id: 'blo', name: 'Baltimore Orioles', first_year: '1882', last_year: '1899'
  add id: 'blt', name: 'Baltimore Terrapins', first_year: '1914', last_year: '1915'
  add id: 'blu', name: 'Baltimore Monumentals', first_year: '1884', last_year: '1884'
  add id: 'bna', name: 'Boston Red Stockings', first_year: '1871', last_year: '1875'
  add id: 'bos', name: 'Boston Red Sox', active: true, img: 'pedrodu01', img_credit: 'http://www.flickr.com/photos/keithallison/2492970513/', player: 'Dustin Pedroia', first_year: '1901', note: 'Also played as Boston Americans.', color: '#BD3039'
  add id: 'bra', name: 'Brooklyn Atlantics', first_year: '1872', last_year: '1875'
  add id: 'brd', name: 'Boston Reds', first_year: '1884', last_year: '1884'
  add id: 'brg', name: 'Brooklyn Gladiators', first_year: '1890', last_year: '1890'
  add id: 'brs', name: 'Boston Reds', first_year: '1890', last_year: '1891'
  add id: 'btt', name: 'Brooklyn Tip-Tops', first_year: '1914', last_year: '1915'
  add id: 'buf', name: 'Buffalo Bisons', first_year: '1879', last_year: '1885'
  add id: 'bww', name: 'Brooklyn Ward’s Wonders', first_year: '1890', last_year: '1890'
  add id: 'cbk', name: 'Columbus Buckeyes', first_year: '1883', last_year: '1884'
  add id: 'cbl', name: 'Cleveland Blues', first_year: '1879', last_year: '1884'
  add id: 'cen', name: 'Philadelphia Centennials', first_year: '1875', last_year: '1875'
  add id: 'cfc', name: 'Cleveland Forest Citys', first_year: '1871', last_year: '1872'
  add id: 'chc', name: 'Chicago Cubs', active: true, img: 'castrst01', img_credit: 'http://www.flickr.com/photos/12154815@N04/8037926942/', player: 'Starlin Castro', first_year: '1876', note: 'Also played as Chicago Orphans, Chicago Colts, and Chicago White Stockings.', color: '#D12325'
  add id: 'chh', name: 'Chicago Whales', first_year: '1914', last_year: '1915', note: 'Also played as Chicago Chi-Feds.'
  add id: 'chp', name: 'Chicago Pirates', first_year: '1890', last_year: '1890'
  add id: 'chw', name: 'Chicago White Sox', active: true, img: 'konerpa01', img_credit: 'http://www.flickr.com/photos/keithallison/7896985130/', player: 'Paul Konerko', first_year: '1901', color: '#000000'
  add id: 'cin', name: 'Cincinnati Reds', active: true, img: 'vottojo01', img_credit: 'http://www.flickr.com/photos/keithallison/5874694122/', player: 'Joey Votto', first_year: '1882', note: 'Also played as Cincinnati Redlegs and Cincinnati Red Stockings.', color: '#EB184B'
  add id: 'ckk', name: 'Cincinnati Kelly’s Killers', first_year: '1891', last_year: '1891'
  add id: 'cle', name: 'Cleveland Indians', active: true, img: 'loftoke01', img_credit: 'http://www.flickr.com/photos/andrewmalone/1959551785/', player: 'Kenny Lofton', first_year: '1901', note: 'Also played as Cleveland Naps, Cleveland Bronchos, and Cleveland Blues.', color: '#023465'
  add id: 'cli', name: 'Cleveland Infants', first_year: '1890', last_year: '1890'
  add id: 'cls', name: 'Columbus Solons', first_year: '1889', last_year: '1891'
  add id: 'clv', name: 'Cleveland Spiders', first_year: '1887', last_year: '1899', note: 'Also played as Cleveland Blues.'
  add id: 'cna', name: 'Chicago White Stockings', first_year: '1871', last_year: '1875'
  add id: 'cnr', name: 'Cincinnati Reds', first_year: '1876', last_year: '1880'
  add id: 'col', name: 'Colorado Rockies', active: true, img: 'heltoto01', img_credit: 'http://www.flickr.com/photos/dirkhansen/3738116090/', player: 'Todd Helton', first_year: '1993', color: '#333366'
  add id: 'cor', name: 'Cincinnati Outlaw Reds', first_year: '1884', last_year: '1884'
  add id: 'cpi', name: 'Chicago/Pittsburgh (Union League)', first_year: '1884', last_year: '1884', note: 'Also played as Chicago/Pittsburgh.'
  add id: 'det', name: 'Detroit Tigers', active: true, img: 'verlaju01', img_credit: 'http://www.flickr.com/photos/keithallison/7578597412/', player: 'Justin Verlander', first_year: '1901', color: '#10293F'
  add id: 'dtn', name: 'Detroit Wolverines', first_year: '1881', last_year: '1888'
  add id: 'eck', name: 'Brooklyn Eckfords', first_year: '1872', last_year: '1872'
  add id: 'fla', name: 'Miami Marlins', active: true, img: 'ramirha01', img_credit: 'http://www.flickr.com/photos/dirkhansen/3745568888/', player: 'Hanley Ramirez', first_year: '1993', note: 'Also played as Florida Marlins.', color: '#00A5B1'
  add id: 'har', name: 'Hartford Dark Blues', first_year: '1876', last_year: '1877', note: 'Also played as Hartfords of Brooklyn.'
  add id: 'hna', name: 'Hartford Dark Blues', first_year: '1874', last_year: '1875'
  add id: 'hou', name: 'Houston Astros', active: true, img: 'berkmla01', img_credit: 'http://www.flickr.com/photos/ableman/152833858/', player: 'Lance Berkman', first_year: '1962', note: 'Also played as Houston Colt .45’s.', color: '#95322C'
  add id: 'ibl', name: 'Indianapolis Blues', first_year: '1878', last_year: '1878'
  add id: 'iho', name: 'Indianapolis Hoosiers', first_year: '1884', last_year: '1884'
  add id: 'ind', name: 'Indianapolis Hoosiers', first_year: '1887', last_year: '1889'
  add id: 'kcc', name: 'Kansas City Cowboys', first_year: '1888', last_year: '1889'
  add id: 'kcn', name: 'Kansas City Cowboys', first_year: '1886', last_year: '1886'
  add id: 'kcp', name: 'Kansas City Packers', first_year: '1914', last_year: '1915'
  add id: 'kcr', name: 'Kansas City Royals', active: true, img: 'greinza01', img_credit: 'http://www.flickr.com/photos/keithallison/3770512483/', player: 'Zack Greinke', first_year: '1969', color: '#000572'
  add id: 'kcu', name: 'Kansas City Cowboys', first_year: '1884', last_year: '1884'
  add id: 'kek', name: 'Fort Wayne Kekiongas', first_year: '1871', last_year: '1871'
  add id: 'lad', name: 'Los Angeles Dodgers', active: true, img: 'kempma01', img_credit: 'http://www.flickr.com/photos/dirkhansen/6007960724/', player: 'Matt Kemp', first_year: '1884', color: '#005596'
  add id: 'lgr', name: 'Louisville Grays', first_year: '1876', last_year: '1877'
  add id: 'lou', name: 'Louisville Colonels', first_year: '1882', last_year: '1899', note: 'Also played as Louisville Eclipse.'
  add id: 'man', name: 'Middletown Mansfields', first_year: '1872', last_year: '1872'
  add id: 'mar', name: 'Baltimore Marylands', first_year: '1873', last_year: '1873'
  add id: 'mil', name: 'Milwaukee Brewers', active: true, img: 'braunry02', img_credit: 'http://www.flickr.com/photos/stoshpaparazzo/8268424583/', player: 'Ryan Braun', first_year: '1969', note: 'Also played as Seattle Pilots.', color: '#012143'
  add id: 'min', name: 'Minnesota Twins', active: true, img: 'mauerjo01', img_credit: 'http://www.flickr.com/photos/keithallison/2312029414/', player: 'Joe Mauer', first_year: '1901', note: 'Also played as Washington Senators.', color: '#042462'
  add id: 'mla', name: 'Milwaukee Brewers', first_year: '1891', last_year: '1891'
  add id: 'mlg', name: 'Milwaukee Grays', first_year: '1878', last_year: '1878'
  add id: 'mlu', name: 'Milwaukee Brewers', first_year: '1884', last_year: '1884'
  add id: 'nat', name: 'Washington Nationals', first_year: '1872', last_year: '1872'
  add id: 'new', name: 'Newark Pepper', first_year: '1914', last_year: '1915', note: 'Also played as Indianapolis Hoosiers.'
  add id: 'nhv', name: 'New Haven Elm Citys', first_year: '1875', last_year: '1875'
  add id: 'nna', name: 'New York Mutuals', first_year: '1871', last_year: '1875'
  add id: 'nyi', name: 'New York Giants', first_year: '1890', last_year: '1890'
  add id: 'nym', name: 'New York Mets', active: true, img: 'wrighda03', img_credit: 'http://www.flickr.com/photos/keithallison/3639903545/', player: 'David Wright', first_year: '1962', color: '#F7742C'
  add id: 'nyp', name: 'New York Metropolitans', first_year: '1883', last_year: '1887'
  add id: 'nyu', name: 'New York Mutuals', first_year: '1876', last_year: '1876'
  add id: 'nyy', name: 'New York Yankees', active: true, img: 'canoro01', img_credit: 'http://www.flickr.com/photos/keithallison/7968125548/', player: 'Robinson Cano', first_year: '1901', note: 'Also played as New York Highlanders and Baltimore Orioles.', color: '#132448'
  add id: 'oak', name: 'Oakland Athletics', active: true, img: 'cespeyo01', img_credit: 'http://www.flickr.com/photos/keithallison/7672898350/', player: 'Yoenis Cespedes', first_year: '1901', note: 'Also played as Kansas City Athletics and Philadelphia Athletics.', color: '#00483A'
  add id: 'oly', name: 'Washington Olympics', first_year: '1871', last_year: '1872'
  add id: 'pbb', name: 'Pittsburgh Burghers', first_year: '1890', last_year: '1890'
  add id: 'pbs', name: 'Pittsburgh Rebels', first_year: '1914', last_year: '1915'
  add id: 'pha', name: 'Philadelphia Athletics', first_year: '1882', last_year: '1890'
  add id: 'phi', name: 'Philadelphia Phillies', active: true, img: 'utleych01', img_credit: 'http://www.flickr.com/photos/imatty35/7696038442/', player: 'Chase Utley', first_year: '1883', note: 'Also played as Philadelphia Quakers.', color: '#CA1F2C'
  add id: 'phk', name: 'Philadelphia Keystones', first_year: '1884', last_year: '1884'
  add id: 'phq', name: 'Philadelphia Athletics', first_year: '1890', last_year: '1891'
  add id: 'pit', name: 'Pittsburgh Pirates', active: true, img: 'mccutan01', img_credit: 'http://www.flickr.com/photos/keithallison/7369332444/', player: 'Andrew McCutchen', first_year: '1882', note: 'Also played as Pittsburgh Alleghenys.', color: '#FFB40B'
  add id: 'pna', name: 'Philadelphia Athletics', first_year: '1871', last_year: '1875'
  add id: 'pro', name: 'Providence Grays', first_year: '1878', last_year: '1885'
  add id: 'pws', name: 'Philadelphia White Stockings', first_year: '1873', last_year: '1875', note: 'Also played as Philadelphia Whites.'
  add id: 'res', name: 'Elizabeth Resolutes', first_year: '1873', last_year: '1873'
  add id: 'ric', name: 'Richmond Virginians', first_year: '1884', last_year: '1884'
  add id: 'roc', name: 'Rochester Broncos', first_year: '1890', last_year: '1890'
  add id: 'rok', name: 'Rockford Forest Citys', first_year: '1871', last_year: '1871'
  add id: 'sbs', name: 'St. Louis Brown Stockings', first_year: '1876', last_year: '1877'
  add id: 'sdp', name: 'San Diego Padres', active: true, img: 'hoffmtr01', img_credit: 'http://www.flickr.com/photos/dirkhansen/2814118351/', player: 'Trevor Hoffman', first_year: '1969', color: '#1C3465'
  add id: 'sea', name: 'Seattle Mariners', active: true, img: 'suzukic01', img_credit: 'http://www.flickr.com/photos/keithallison/5712089370/', player: 'Ichiro', first_year: '1977', color: '#003166'
  add id: 'sfg', name: 'San Francisco Giants', active: true, img: 'bondsba01', img_credit: 'http://www.flickr.com/photos/kevinrushforth/225833857/', player: 'Barry Bonds', first_year: '1883', note: 'Also played as New York Giants and New York Gothams.', color: '#FB5B1F'
  add id: 'sli', name: 'St. Louis Terriers', first_year: '1914', last_year: '1915'
  add id: 'slm', name: 'St. Louis Maroons', first_year: '1884', last_year: '1886'
  add id: 'slr', name: 'St. Louis Red Stockings', first_year: '1875', last_year: '1875'
  add id: 'sna', name: 'St. Louis Brown Stockings', first_year: '1875', last_year: '1875'
  add id: 'stl', name: 'St. Louis Cardinals', active: true, img: 'carpech01', img_credit: 'http://www.flickr.com/photos/keithallison/8075839055/', player: 'Chris Carpenter', first_year: '1882', note: 'Also played as St. Louis Perfectos, St. Louis Browns, and St. Louis Brown Stockings.', color: 'C41E3A'
  add id: 'stp', name: 'St. Paul Apostles', first_year: '1884', last_year: '1884', note: 'Also played as St. Paul White Caps.'
  add id: 'syr', name: 'Syracuse Stars', first_year: '1879', last_year: '1879'
  add id: 'sys', name: 'Syracuse Stars', first_year: '1890', last_year: '1890'
  add id: 'tbd', name: 'Tampa Bay Rays', active: true, img: 'priceda01', img_credit: 'http://www.flickr.com/photos/keithallison/2881485220/', player: 'David Price', first_year: '1998', note: 'Also played as Tampa Bay Devil Rays.', color: '#00285D'
  add id: 'tex', name: 'Texas Rangers', active: true, img: 'hamiljo03', img_credit: 'http://www.flickr.com/photos/keithallison/7156380592/', player: 'Josh Hamilton', first_year: '1961', note: 'Also played as Washington Senators.', color: '#01317B'
  add id: 'tlm', name: 'Toledo Maumees', first_year: '1890', last_year: '1890'
  add id: 'tol', name: 'Toledo Blue Stockings', first_year: '1884', last_year: '1884'
  add id: 'tor', name: 'Toronto Blue Jays', active: true, img: 'bautijo02', img_credit: 'http://www.flickr.com/photos/keithallison/6019208107/', player: 'Jose Bautista', first_year: '1977', color: '#0067A6'
  add id: 'tro', name: 'Troy Haymakers', first_year: '1871', last_year: '1872'
  add id: 'trt', name: 'Troy Trojans', first_year: '1879', last_year: '1882'
  add id: 'was', name: 'Washington Senators', first_year: '1891', last_year: '1899', note: 'Also played as Washington Statesmen.'
  add id: 'wbl', name: 'Washington Blue Legs', first_year: '1873', last_year: '1873'
  add id: 'wes', name: 'Keokuk Westerns', first_year: '1875', last_year: '1875'
  add id: 'wil', name: 'Wilmington Quicksteps', first_year: '1884', last_year: '1884'
  add id: 'wna', name: 'Washington Nationals', first_year: '1884', last_year: '1884'
  add id: 'wnl', name: 'Washington Nationals', first_year: '1886', last_year: '1889'
  add id: 'wnt', name: 'Washington Nationals', first_year: '1875', last_year: '1875'
  add id: 'wor', name: 'Worcester Ruby Legs', first_year: '1880', last_year: '1882'
  add id: 'wsn', name: 'Washington Nationals', active: true, img: 'harpebr03', img_credit: 'http://www.flickr.com/photos/keithallison/7436455670/', player: 'Bryce Harper', first_year: '1969', note: 'Also played as Montreal Expos.', color: '#14225A'
  add id: 'wst', name: 'Washington Statesmen', first_year: '1884', last_year: '1884', note: 'Also played as Washington Nationals.'

end
