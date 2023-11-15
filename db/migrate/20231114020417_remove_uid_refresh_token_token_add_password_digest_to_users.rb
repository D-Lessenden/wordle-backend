class RemoveUidRefreshTokenTokenAddPasswordDigestToUsers < ActiveRecord::Migration[6.0]
  def change
    change_table :users do |t|
      t.remove :uid, :refresh_token, :token
      t.string :password_digest
    end
  end
end