class CreatePushers < ActiveRecord::Migration
  def change
    create_table :pushers do |t|
      t.string :identifier
      t.string :key
      t.references :application
      t.timestamps
    end
  end
end
