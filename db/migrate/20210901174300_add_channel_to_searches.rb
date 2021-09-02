class AddChannelToSearches < ActiveRecord::Migration[6.0]
  def change
    add_column :searches, :channel, :string
  end
end
