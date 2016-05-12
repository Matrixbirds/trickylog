class Session
  include ActiveModel::Model

  attr_accessor :username, :password

  validates :username, presence: true
  validates :password, presence: true

  def create
    if valid?
      if (user = User.find_by(name: username)) && user.authenticate(password)
        user
      end
    end
  end
end
