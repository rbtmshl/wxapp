class ChangeDataTypeForForecastQpf < ActiveRecord::Migration
  def self.up
    change_table :forecasts do |t|
      t.change :qpf, :integer
    end
  end

  def down
    change_table :forecasts do |t|
      t.change :qpf, :float
    end
  end
end
