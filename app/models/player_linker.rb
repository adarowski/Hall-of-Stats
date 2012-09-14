class PlayerLinker
  REGEX = /([\s\b])(@(.+?\d+))/

  def initialize(input)
    @input = input
  end

  def link_text
    player_ids = @input.scan(REGEX).map(&:last).uniq

    players = Hash[Player.where(id: player_ids).map do |player|
      [player.id, PlayerDecorator.new(player)]
    end]

    @input.gsub(REGEX) do |match|
      $1 << players[$3].link
    end
  end
end
