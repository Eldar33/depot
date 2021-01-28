class User < ApplicationRecord
  validates :name, presence: true, uniqueness: true

  # Добавлено после генерации scaffold password:digest
  # для двух полей для паспорта (второе это подтверждение пароля)
  has_secure_password
end
