class BioFormatter
  REGEX = /(^|[\W])(@(.+?\d+))(:\w+)?/

  def initialize(input, context = nil)
    @input = input.strip
    @context = context
  end

  def to_s
    mark_down(linked_text)
  end

  def linked_text
    @linked_text ||= link_text
  end

  def mentioned_players
    player_ids = @input.scan(REGEX).map{|m| m[2]}.uniq
    Player.where(id: player_ids)
  end

  private

  def link_text
    players = Hash[mentioned_players.map do |player|
      [player.id, PlayerDecorator.new(player)]
    end]

    @input.gsub(REGEX) do |match|
      player = players[$3]
      if player
        field_index = match.index(':').try(:+, 1)
        if !field_index.nil?
          field = match[field_index..-1]
          $1 << player.send(field).to_s
        elsif player.id == @context
            $1 << player.name
        else
          $1 << %([#{player.name}](#{player.link} "#{player.view_player_text}"))
        end
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
