class RenameNameAndAddAttributesToEntries < ActiveRecord::Migration[7.0]
  def change
    # Step 1: Rename "name" column to "place_name"
    rename_column :entries, :name, :place_name

    # Step 2: Add new attributes to the "entries" table
    add_column :entries, :description, :text
    add_column :entries, :latitude, :float
    add_column :entries, :longitude, :float
    add_column :entries, :date_visited, :date

    # Step 3: Add any necessary indexes or other modifications
    # Example:
    # add_index :entries, :date_visited
  end
end
