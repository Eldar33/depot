
class User < ApplicationRecord
  validates :name, presence: true, uniqueness: true

  # Добавлено после генерации scaffold password:digest
  # для двух полей для паспорта (второе это подтверждение пароля)
  has_secure_password

  after_destroy :ensure_an_admin_remains

  class Error < StandardError
  end

  private 
    def ensure_an_admin_remains
      if User.count.zero?
        # Исключение откатывает удаление последнего пользователя
        # и передает сообщение пользователю, можно обработать в контроллере
        # в блоке rescue_from 
        raise Error.new "Can't delete last user"
      end
    end
end


