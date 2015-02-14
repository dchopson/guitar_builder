class CreateGuitars < ActiveRecord::Migration
  def change
    create_table :guitars do |t|
      t.string :body_style
      t.string :body_wood
      t.string :body_finish
      t.boolean :pick_guard
      t.string :fretboard_wood
      t.string :fretboard_finish
      t.boolean :fretboard_markers
      t.string :neck_wood
      t.string :neck_finish
      t.string :tuning_peg_style
      t.string :tuning_peg_layout
      t.string :string_type
      t.references :order, index: true

      t.timestamps
    end
  end
end
