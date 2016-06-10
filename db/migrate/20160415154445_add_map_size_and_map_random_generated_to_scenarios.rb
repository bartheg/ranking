class AddMapSizeAndMapRandomGeneratedToScenarios < ActiveRecord::Migration
  def change
    add_column :scenarios, :map_size, :string
    add_column :scenarios, :map_random_generated, :boolean
  end
end
