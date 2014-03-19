require 'openssl'
require 'digest'
require 'base64'

class DjangoHash
  attr_reader :hsh

  def initialize(params)
    @password  = params[:password]
    @dklen     = params[:dklen]    || 32
    @c         = params[:c].to_i   || 12000
    @hsh       = params[:hash]
    @salt      = params[:salt]

    @hash_f = OpenSSL::Digest.new("sha256")
  end

  # Instanciate class using hash string
  def self.parse(str)
    algo,c,salt,hsh = str.split('$')
    raise "sorry, don't know what to do with #{algo}" unless algo == 'pbkdf2_sha256'
    DjangoHash.new(
      :dklen => Base64.decode64(hsh).size,
      :c     => c,
      :salt  => salt,
      :hash  => hsh,
    )
  end

  # Compute hash
  def get_hash
    (1..number_of_blocks).map(&block).reduce("",&:<<)
  end

  # Check password against computed hash
  def check_password(password)
    @password = password
    @hsh == get_hash
  end

  private

  def number_of_blocks
    (@dklen.to_f/@hash_f.size).ceil
  end

  # "string xor"
  def xor(s1,s2)
    s1.bytes.zip((s2).bytes).map{|a,b| a ^ b}.pack("C*")
  end

  # Pseudo Random Function, as described in wikipedia
  def prf(data)
    OpenSSL::HMAC.digest(OpenSSL::Digest.new("sha256"),@password, data)
  end

  def block
    -> i {
      u = prf(@salt+[i].pack("N"))
      f = u
      2.upto(@c) do |i|
        u = prf(u)
        f = xor(f,u)
      end
      Base64.encode64(f[0..@dklen-1]).chomp
    }
  end
end
