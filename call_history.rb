class Call_history 
  attr_accessor :call_type
  attr_accessor :name
  attr_accessor :num
  attr_accessor :call_time
  attr_accessor :length

  def initialize(record_hash)
    @call_type = record_hash['Call Type']
    @name = record_hash['Name']
    @num = record_hash['Number']
    @call_time = record_hash['When']
    @length = record_hash['Length']
  end 

  def to_str 
    "call_type: #{@call_type}, name: #{@name}, num: #{@num}, call_time: #{@call_time}, length: #{@length}"
  end 
end 