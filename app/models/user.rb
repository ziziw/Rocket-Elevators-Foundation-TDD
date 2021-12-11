# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable,
         :recoverable, :rememberable, :validatable

  has_many :employees, dependent: :destroy
  has_one :customer, dependent: :destroy
  # class_name: "employee", foreign_key: "employees_id" i did remove this one it works with it though

  validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, on: :create }
  validate :valid_password

  ### https://stackoverflow.com/questions/19605150/regex-for-password-must-contain-at-least-eight-characters-at-least-one-number-a
  def valid_password
    ### Minimum eight characters, at least one uppercase letter, one lowercase letter, one number and one special character:
    if password.blank? || password =~ /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$/
      errors.add :password, "Minimum eight characters, at least one uppercase letter, one lowercase letter, one number and one special character"
    end
  end
  
  def to_s
    self.first_name + " " + self.last_name
  end
end
