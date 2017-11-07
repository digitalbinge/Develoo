class OrderItem < ApplicationRecord
  belongs_to :commission
  belongs_to :user_story
  belongs_to :order

  validates :quantity, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validate :commission_present
  validate :user_story_present
  validate :order_present

  before_save :finalize

  def unit_price
    if persisted?
      self[:unit_price]
    else
      product.price
    end
  end

  def total_price
    unit_price * quantity
  end

  private

  def commission_present
    if commission.nil?
      errors.add(:commission, "is not valid or is not active.")
    end
  end

  def user_story_present
    if user_story.nil?
      errors.add(:user_story, "is not valid or is not active.")
    end
  end

  def order_present
    if order.nil?
      errors.add(:order, "is not a valid order.")
    end
  end

  def finalize
    self[:unit_price] = unit_price
    self[:total_price] = quantity * self[:unit_price]
  end
end
