class BioFormatter
  REGEX = /(^|[\W])(@(.+?\d+))/

  def initialize(input)
    @input = input.strip
  end

  def to_s
    mark_down(linked_text)
  end

  def linked_text
    @linked_text ||= link_text
  end

  private

  def link_text
    player_ids = @input.scan(REGEX).map(&:last).uniq

    players = Hash[Player.where(id: player_ids).map do |player|
      [player.id, PlayerDecorator.new(player)]
    end]

    @input.gsub(REGEX) do |match|
      player = players[$3]
      if player
        $1 << %([#{player.name}](#{player.link} "#{player.view_player_text}"))
      else
        warn "could not find #{match}"
        match
      end
    end
  end

  def mark_down(content)
    Redcarpet::Markdown.new(Redcarpet::Render::HTML).render(content)
  end
end
