class CreateAnnotations < ActiveRecord::Migration
  def change
    create_table :annotations do |t|
      t.string :label
      t.integer :priority
      t.string :prefer_user
      t.string :text_file
      t.string :image_files
      t.integer :user_id
      t.datetime :finished
      t.boolean :skipped
      t.string :appropriate
      t.string :not_appropriate

      t.timestamps
    end
  end
end
