module ApplicationHelper
  def body_attributes
    case [params[:controller], params[:action]].join('#')
    when 'players#index'
      {class: 'home'}
    when 'players#show'
      {class: @player.body_classes.join(' '), id: @player.id}
    when 'articles#show'
      {class: 'article'}
    when 'about#index'
      {class: 'about'}
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
      active_and_worthy:  'Active and Hall-Worthy'
    }
  end
end
