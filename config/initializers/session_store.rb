# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_filmynumber_session',
  :secret      => '328053ea11e2806676542998b23db15b0b8df772f305831273b77375c23b6a3b52f90a78c689c21ffcce911797772c7ad8ae8263ee7e861b2a4b63827cad7e9d'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
