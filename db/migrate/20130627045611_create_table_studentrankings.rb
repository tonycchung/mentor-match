class CreateTableStudentrankings < ActiveRecord::Migration
  def change
    create_table :studentrankings do |t|
      t.integer :mentor_id
      t.integer :student_id
      t.integer :rank

      t.timestamps
    end
  end
end
