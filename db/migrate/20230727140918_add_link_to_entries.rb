class AddLinkToEntries < ActiveRecord::Migration[7.0]
  def change
    add_column :entries, :link, :string
  end
end
