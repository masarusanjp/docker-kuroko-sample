# This migration comes from kuroko2 (originally 4)
class CreateTicks < ActiveRecord::Migration
  def change
    create_table "ticks" do |t|
      t.datetime "at"
    end
  end
end
