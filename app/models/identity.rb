# == Schema Information
# Schema version: 20160310132348
#
# Table name: identities
#
#  id       :uuid             not null, primary key
#  uid      :string
#  provider :string
#  user_id  :uuid             indexed
#
# Indexes
#
#  index_identities_on_user_id  (user_id)
#

class Identity < ActiveRecord::Base
  belongs_to :user

  def self.find_with_omniauth(auth)
    find_by uid: auth['uid'], provider: auth['provider']
  end

  def self.create_with_omniauth(auth)
    create uid: auth['uid'], provider: auth['provider']
  end
end
