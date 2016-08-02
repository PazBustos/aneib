class CreateEventComments < ActiveRecord::Migration
  def change
    create_table :event_comments do |t|
      t.text :body
      t.references :user, index: true, foreign_key: true
      t.references :event, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
