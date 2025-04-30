x = [{"a" => 10},{"b" => 20},{"c" => 30}]

# We need the following
# 1. one array containing all keys
# 2. another array containing all values
# 3. the sum of all the values
# Example
# ["a", "b", "c"]
# [10, 20, 30]
# 60

keys = x.map(&:keys).flatten

values = x.map(&:values).flatten

sum = values.sum

puts keys.inspect
puts values.inspect

puts sum


