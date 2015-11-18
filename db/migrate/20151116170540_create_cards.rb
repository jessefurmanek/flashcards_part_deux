class CreateCards < ActiveRecord::Migration
  def change
    unless ActiveRecord::Base.connection.tables.include? 'cards'
      create_table :cards do |table|
        table.column :name, :string
        table.column :front, :string
        table.column :back, :string
        table.column :last_reviewed, :datetime
        table.column :interval, :integer
      end
    end
  end
end
