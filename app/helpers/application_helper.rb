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
    [
      player.position,
      player.hof ? "hof" : "not-hof",
      player.hos ? "hos" : "not-hos",
      player.hall_worthy? && !player.hos ? "upcoming" : nil,
    ]
  end

  def host_href
    Rails.env.production? ? "http://#{request.host}" : "http://#{request.host}:#{request.port}"
  end

  def absolutize(content)
    Absolutizer.absolutize_html(content, host_href)
  end
end
