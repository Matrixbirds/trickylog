# == Schema Information
# Schema version: 20160310132348
#
# Table name: articles
#
#  id             :uuid             not null, primary key
#  title          :string           not null
#  description    :string
#  author_id      :uuid             not null
#  content        :text             not null
#  comments_count :string           default("0"), not null
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  status         :integer          default(0), not null
#
# Foreign Keys
#
#  fk_rails_e74ce85cbc  (author_id => users.id)
#

module ArticlesHelper
end
