# frozen_string_literal: true

class Employee < ApplicationRecord
  belongs_to :user
  has_many :batteries, dependent: :destroy
  has_many :interventions

  def to_s
    "Employee #" + self.id.to_s
  end

  def full_name
    "#{first_name} #{last_name}"
  end
end
