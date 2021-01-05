module FormattedPriceConcern
  extend ActiveSupport::Concern

  def formatted(price)
    ('%.2f' % price).gsub('.', ',')
  end
end
