class FranchiseDecorator < Draper::Decorator
  decorates :franchise

  delegate_all
  delegate :name, to: :franchise

  def keywords
    [
      franchise.name,
      "#{franchise.name} stats",
      "Sabermetrics"
    ].join(",")
  end
end
