class CreateHistories < ActiveRecord::Migration
  def self.up
    create_table :histories, :force => true do |t|
      t.integer   :historizable_id,        :null => false
      t.string    :historizable_type,      :null => false
      t.datetime  :created_at,             :null => false
    end
  end

  def self.down
    drop_table :histories
  end
end