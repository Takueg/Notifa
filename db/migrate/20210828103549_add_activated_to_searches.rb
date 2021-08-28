class AddActivatedToSearches < ActiveRecord::Migration[6.0]
  def change
    add_column :searches, :activated, :boolean, :default => true
  end
end
