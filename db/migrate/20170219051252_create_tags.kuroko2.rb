# This migration comes from kuroko2 (originally 19)
class CreateTags < ActiveRecord::Migration
  def change
    create_table "tags" do |t|
      t.string   "name",       limit: 100, null: false
      t.datetime "created_at",             null: false
      t.datetime "updated_at",             null: false
    end

    add_index "tags", ["name"], unique: true, using: :btree
  end
end
