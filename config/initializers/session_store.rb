# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_dailystamp_session',
  :secret      => 'eb56cbf5d5e3b0d7c8de4271c428534b2dd3ce59f13488cb60abab274eee8b5be08eeae2d0aedbc40d4da3985f91c56a0a1651775c0a98aa75f3f9a239f66df4'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
