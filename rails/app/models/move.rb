class Move < ActiveRecord::Base
  belongs_to :position, :foreign_key => "to_position_id"
  # belongs_to :from_position, :class_name => "Position", :foreign_key => "from_position_id"
end
