class Subcategory < ActiveRecord::Base
  has_many   :expenses
  belongs_to :category
  delegate   :label, to: :category, prefix: true

  before_create :generate_color

  def value
    @value ||= expenses.inject(0) { |sum,x|  sum + x.value }
  end

  def generate_color
    self.color = "%06x" % (rand * 0xffffff)
  end

  def as_json(options = {})
    {
      label: label,
      value: value,
      color: color
    }
  end
end
