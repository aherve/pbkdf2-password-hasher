pbkdf2-password-hasher
======================

Compute a pbkdf2 hash of a string, and/or check a password against a pbkdf2 hashed string.

This was originally built to import password hashes from django application to rails/devise application

## Installation

In your Gemfile : 
```ruby
gem pbkdf2_password_hasher, git: 'aherve/pbkdf2-password-hasher'
```

or install it with:
```ruby
gem install pbkdf2_password_hasher
```

## Usage

- Hash a password with salt:
```ruby
salt = 'NaCl'    # random salt key
pass = 's3cr3t'  # your password
it   = 1000      # number of iterations

hah = Pbkdf2PasswordHasher.has_password(pass,salt,it)
```
- Check password validity against string

```ruby
# hashed string from django app
hsh ='pbkdf2_sha256$12000$PEnXGf9dviXF$2soDhu1WB8NSbFDm0w6NEe6OvslVXtiyf4VMiiy9rH0=' 

# with right password:
Pbkdf2PasswordHasher.check_password('bite',hsh) #=> true

#with wrong password:
Pbkdf2PasswordHasher.check_password('bitten',hsh) #=> false
```
