class Category < ActiveRecord::Base
  has_many :subcategories
  before_create :generate_color

  def value
    @value ||= subcategories.inject(0) {|sum,x| sum + x.value }
  end

  def generate_color
    self.color = "%06x" % (rand * 0xffffff)
  end

  def as_json(options = {})
    {
      label: label,
      value: value,
      color: color,
      subcategories: subcategories
    }
  end
end