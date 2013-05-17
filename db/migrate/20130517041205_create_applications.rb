class CreateApplications < ActiveRecord::Migration
  def change
    create_table :applications do |t|
      t.string :identifier
      t.string :application_token

      t.timestamps
    end
  end
end
