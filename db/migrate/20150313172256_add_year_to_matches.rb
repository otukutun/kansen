class AddYearToMatches < ActiveRecord::Migration
  def change
    add_column :matches, :year, :string
  end
end
