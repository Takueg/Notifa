class AddProfileAvatarToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :profile_avatar, :string
  end
end
