require 'ys1'

hash = {:id => 1, :name => "y"}

no_name_class = YS1::HashToClass.create_dynamic_class(hash)

nnc = no_name_class.new

nnc.id

nnc.name
