class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :email
      t.string :provider
      t.string :token
      t.string :refresh_token
      t.string :uid
      t.index :uid

      t.timestamps
    end
  end
end
