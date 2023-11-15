class UserSerializer
    include FastJsonapi::ObjectSerializer
    attributes :id, :email
  
    has_one :game_history
  end