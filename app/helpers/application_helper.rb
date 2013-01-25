module ApplicationHelper
  def body_attributes
    case [params[:controller], params[:action]].join('#')
    when 'players#index'
      {class: 'home'}
    when 'players#show'
      {class: @player.body_classes.join(' '), id: @player.id}
    when 'articles#index'
      {class: 'article'}
    when 'articles#show'
      {class: 'article'}
    when 'about#index'
      {class: 'about'}
    when 'position#show'
      {class: 'position'}
    end
  end

  def safe_id(id)
    id.gsub(/['\.]/, '')
  end

  def filter_data(player)
    PlayerFilter.filters_for(player)
  end

  def host_href
    Rails.env.production? ? "http://#{request.host}" : "http://#{request.host}:#{request.port}"
  end

  def absolutize(content)
    Absolutizer.absolutize_html(content, host_href)
  end

  def non_position_filters
    { added:              'Added to the Hall',
      removed:            'Removed from the Hall',
      upcoming:           'Not Yet Eligible but Hall-Worthy',
      active_and_worthy:  'Active and Hall-Worthy',
      near_misses:          'Near Misses'
    }
  end

  def title_or_default
    if content_for?(:title)
      "Hall of Stats: #{content_for(:title)}"
    else 
      "Hall of Stats"
    end
  end

  def ordinalize_with_delimiter(number)
    delimited = number_with_delimiter(number)
    ordinal_suffix = number.ordinalize.gsub(/\d+/, '')
    "#{delimited}#{ordinal_suffix}"
  end

  def overall_percentage(player)
    top_percent = "%.1f" % (player.ranking_overall * 100.0 / Player.count)
    "Top #{top_percent < "0.1" ? "<0.1" : top_percent}"
  end
end
