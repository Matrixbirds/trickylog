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
#

FactoryGirl.define do
  factory :user do

    name FFaker::Name.name
    password '123123123'
    password_confirmation '123123123'

    trait :female do
      gender User.genders[:female]
    end

    trait :male do
      gender User.genders[:male]
    end

  end
end
