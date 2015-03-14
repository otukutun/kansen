class AddSectionToMatches < ActiveRecord::Migration
  def change
    add_column :matches, :section, :string
  end
end
