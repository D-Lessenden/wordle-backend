class UserSerializer
    include FastJsonapi::ObjectSerializer
    attributes :id, :email, :game_history
  
    has_one :game_history, serializer: GameHistorySerializer
  end