require 'pbkdf2_password_hasher/version'
require 'pbkdf2_password_hasher/django_hash'

module Pbkdf2PasswordHasher
  class << self
    # compute a hash from password, salt, number of iterations, and key length
    def hash_password(pass, salt, nb_of_iterations, key_length = 32)
      hsh = DjangoHash.new(
        :password => pass,
        :salt     => salt,
        :c        => nb_of_iterations,
        :dklen    => key_length
      ).get_hash
      "pbkdf2_sha256$#{nb_of_iterations}$#{salt}$#{hsh}"
    end

    # Check password against hash string
    def check_password(pass, hash)
      DjangoHash.parse(hash).check_password(pass)
    end
  end
end
