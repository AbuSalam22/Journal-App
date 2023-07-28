class CreateJournalTables < ActiveRecord::Migration[7.0]
  def change
    create_table :journal_tables do |t|
      t.string :name

      t.timestamps
    end
  end
end
