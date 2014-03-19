require "pbkdf2_password_hasher/version"
require 'pbkdf2_password_hasher/django_hash'

module Pbkdf2PasswordHasher

  class << self

  def hash_password(pass,salt,nb_of_iterations,key_length=32)
    DjangoHash.new(
      :password => pass,
      :salt     => salt,
      :c        => nb_of_iterations,
      :dklen    => key_length,
    ).get_hash
  end

  def check_password(pass,hash)
    DjangoHash::parse(hash).check_password(pass)
  end

  end

end

