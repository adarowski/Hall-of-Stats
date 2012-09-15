class BioFormatter
  REGEX = /([\s\b])(@(.+?\d+))/
  READ_MORE_LINK = %( <a href="#" id="show-bio">Read more&hellip;</a>)

  def initialize(input)
    @input = input.strip
  end

  def lead_in
    @lead_in ||= md_lead_in
  end

  def body
    @body ||= md_body
  end

  def linked_text
    @linked_text ||= link_text
  end

  private

  def md_lead_in
    lead_in_content, body_content = link_text.split("\n\n", 2)

    if lead_in_content.present?
      if body_content.present?
        lead_in_content << READ_MORE_LINK
      end
      mark_down(lead_in_content)
    end
  end

  def md_body
    body_content = link_text.split("\n\n", 2)[1]

    if body_content.present?
      mark_down(body_content)
    end
  end

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
        warn "could not find #{$match}"
        $0
      end
    end
  end

  def mark_down(content)
    Redcarpet::Markdown.new(Redcarpet::Render::HTML).render(content)
  end
end
