class CreateNewusers < ActiveRecord::Migration
  def self.up
    create_table :newusers do |t|
      t.string :username
      t.string :name
      t.string :shell
      t.string :email
      t.string :phone

      t.timestamps
    end
  end

  def self.down
    drop_table :newusers
  end
end
