# This migration comes from kuroko2 (originally 26)
class AddWebhookUrlToJobDefinitions < ActiveRecord::Migration
  def change
    add_column :job_definitions, :webhook_url, :text
  end
end
