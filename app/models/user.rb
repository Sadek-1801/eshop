class User < ApplicationRecord
  after_destroy :ensure_an_admin_remains
  validates :name, uniqueness: { case_sensitive: false }
  has_secure_password

  class Error < StandardError
  end

  private
    def ensure_an_admin_remains
      if User.count.zero?
        raise Error.new "Can't delete last user"
      end
    end
end
