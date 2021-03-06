class CreateAnswers < ActiveRecord::Migration
  def change
    create_table :answers do |t|
      t.text :body
      t.belongs_to :question, index: true

      t.timestamps null: false
    end
    add_foreign_key :answers, :questions
  end
end
