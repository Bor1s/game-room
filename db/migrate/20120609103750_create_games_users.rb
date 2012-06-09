class CreateGamesUsers < ActiveRecord::Migration
  def change
    create_table :games_users, :id => false do |t|
      t.references :game
      t.references :user
    end
  end
end
