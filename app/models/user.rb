# == Schema Information
# Schema version: 20160310132348
#
# Table name: users
#
#  id               :uuid             not null, primary key
#  name             :string           not null
#  encrypted_passwd :string           not null
#  gender           :integer
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  status           :integer          default(0), not null
#  role             :integer
#

require 'hackable/encrypted_passwd'
require 'securerandom'
class User < ActiveRecord::Base
  include EncryptedPasswd
  acts_as_encrypted_passwd

  enum gender: %i[male female]
  enum status: %i[normal deprecated hidden]
  enum role: %i[visitor admin]
  has_many :comments, foreign_key: :author_id
  has_many :articles, foreign_key: :author_id
  has_many :identities
  has_many :messages

  validates :name, presence: true
  validates :password, :password_confirmation, presence: true, if: :should_validate?
  validates :name, uniqueness: { case_sensitive: false }
  validates :password, confirmation: true, if: :should_validate?

  def should_validate?
    new_record? || (password && password_confirmation)
  end

  def self.create_with_oauth_identity(oauth_hash)
    password = SecureRandom.hex
    create(name: oauth_hash["info"]["nickname"], :password => password, :password_confirmation => password)
  end
end
