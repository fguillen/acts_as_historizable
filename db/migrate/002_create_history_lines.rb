class CreateHistoryLines < ActiveRecord::Migration
  def self.up
    create_table :history_lines, :force => true do |t|
      t.integer   :history_id,          :null => false
      t.string    :field_name,          :null => false
      t.string    :field_value_was,     :null => false
      t.string    :field_value_actual,  :null => false
    end
  end

  def self.down
    drop_table :history_lines
  end
end