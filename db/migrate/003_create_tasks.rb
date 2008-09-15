class CreateTasks < ActiveRecord::Migration
  def self.up
    create_table :tasks, :force => true do |t|
      t.string    :title,                :null => false
      t.string    :description,          :null => false
      t.datetime  :created_at,           :null => false
      t.datetime  :updated_at,           :null => false
    end
  end

  def self.down
    drop_table :tasks
  end
end