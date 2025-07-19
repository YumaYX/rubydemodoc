a = ["z3qx", "l9ma", "b77r", "x1p0"]
b = ["x1p0", "l9ma", "wxyz"]

# 名前順（アルファベット順）で最初の共通要素
puts (a & b).sort.first

# aの順序に従った最初の共通要素
puts a.find { |x| b.include?(x) }
