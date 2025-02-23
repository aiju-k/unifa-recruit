class CreateUsers < ActiveRecord::Migration[7.2]
  def change
    create_table :users do |t|
      t.string :login_id,        null: false, index: { unique: true }
      t.string :password_digest, null: false

      t.timestamps
    end
  end
end
