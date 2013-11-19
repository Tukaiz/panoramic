class AddSiteIdToDatabaseTemplates < ActiveRecord::Migration
  def change
    add_column :database_templates, :site_id, :integer
  end
end
