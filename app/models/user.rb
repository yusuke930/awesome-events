class User < ApplicationRecord
  has_many :created_events, class_name: "Event", foreign_key: "owner_id"
  has_many :tickets
  
  def self.find_or_create_auth_hash!(auth_hash)
    provider = auth_hash[:provider]
    uid = auth_hash[:uid]
    nickname = auth_hash[:info][:nickname]
    image_url = auth_hash[:info][:image]
    logger.debug "#{auth_hash}"

    User.find_or_create_by!(provider: provider, uid: uid) do |user|
      user.name = nickname
      user.image_url = image_url
    end
  end
end

# find_or_create_by! : occuer ActiveRecord::RecordInvalid
# find_or_create_by : don't occuer error