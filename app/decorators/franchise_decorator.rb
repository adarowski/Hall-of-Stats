class FranchiseDecorator < Draper::Base
  decorates :franchise

  delegate :name, to: :franchise

  def keywords
    [
      franchise.name,
      "#{franchise.name} stats",
      "Sabermetrics"
    ].join(",")
  end
end
