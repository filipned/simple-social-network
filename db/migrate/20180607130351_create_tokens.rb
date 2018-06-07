class CreateTokens < ActiveRecord::Migration[5.0]
  def change
    create_table :tokens do |t|
      t.string :token, unique: true
      t.references :user, index: true, foreign_key: true

      t.timestamps
    end
  end
end
