require 'ys1'

data = %w(a b c d e)

YS1::Report.save(data)

data = ""

YS1::Report.load

