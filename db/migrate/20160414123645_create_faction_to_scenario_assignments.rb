class CreateFactionToScenarioAssignments < ActiveRecord::Migration
  def change
    create_table :faction_to_scenario_assignments do |t|
      t.references :faction, index: true, foreign_key: true
      t.references :scenario, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
