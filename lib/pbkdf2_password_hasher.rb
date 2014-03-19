require "pbkdf2_password_hasher/version"

module Pbkdf2PasswordHasher
  # Your code goes here...
end

#class DjangoHash
#  attr_accessor :hsh
#
#  def initialize(params)
#    @pass  = params[:password]
#    @dklen = params[:dklen]    ||32
#    @c     = params[:c].to_i   ||12000
#    @hsh   = params[:hash]
#    @salt  = params[:salt]
#
#    @hash_f = OpenSSL::Digest.new("sha256")
#  end
#
#  def self.parse(str)
#    algo,c,salt,hsh = str.split('$')
#    raise "sorry, don't know what to do with #{algo}" unless algo == 'pbkdf2_sha256'
#    DjangoHash.new(
#      :dklen => Base64.decode64(hsh).size,
#      :c     => c,
#      :salt  => salt,
#      :hash  => hsh,
#    )
#  end
#
#  def hash_with_password(password)
#    @password = password
#    (1..number_of_blocks).map(&block).reduce("",&:<<)
#  end
#
#  def check_password(password)
#    @hsh == hash_with_password(password)
#  end
#
#  private
#
#  def number_of_blocks
#    (@dklen.to_f/@hash_f.size).ceil
#  end
#
#  def xor(s1,s2)
#    s1.bytes.zip((s2).bytes).map{|a,b| a ^ b}.pack("C*")
#  end
#
#  def prf(data)
#    OpenSSL::HMAC.digest(OpenSSL::Digest.new("sha256"),@password, data)
#  end
#
#  def block
#    -> i {
#      u = prf(@salt+[i].pack("N"))
#      f = u
#      2.upto(@c) do |i|
#        u = prf(u)
#        f = xor(f,u)
#      end
#      Base64.encode64(f[0..@dklen-1]).chomp
#    }
#  end
#
#end
#
#my_hash='pbkdf2_sha256$12000$PEnXGf9dviXF$2soDhu1WB8NSbFDm0w6NEe6OvslVXtiyf4VMiiy9rH0='
#d = DjangoHash::parse(my_hash)
#p d.check_password('bite')
