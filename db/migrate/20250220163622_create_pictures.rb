class CreatePictures < ActiveRecord::Migration[7.2]
  def change
    create_table :pictures do |t|
      t.references :user, foreign_key: true, null: false
      t.string :title, null: false
      t.timestamps
    end
  end
end
