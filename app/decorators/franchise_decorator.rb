class FranchiseDecorator < Draper::Decorator
  decorates :franchise

  delegate_all

  def keywords
    [
      franchise.name,
      "#{franchise.name} stats",
      "Sabermetrics"
    ].join(",")
  end
end
