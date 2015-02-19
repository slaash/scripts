# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_webapp1_session',
  :secret      => '734524c6ed7432a85d0563cc44313389edff6ff7b81582cb5c76e0b5e3b6a52292ac60c32158cf5840f06d249fad09b801e06e8f34f51fa1b6bfcb1bd9c84900'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
