class CreatePictures < ActiveRecord::Migration[5.1]
  def change
    create_table :pictures do |t|
      t.attachment :image, null: false
      t.string :name
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
