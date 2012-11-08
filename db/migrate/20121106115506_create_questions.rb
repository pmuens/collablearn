class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.string :title
      t.text :question
      t.text :answer
      t.references :user
      t.references :collection

      t.timestamps
    end
    add_index :questions, :user_id
    add_index :questions, :collection_id
  end
end
