require 'ys1'

text_file = File.read("input/Text/extract_with_mark.txt")
pac = YS1::Text.extract_with_mark(text_file, /^# /)
pac.map { |element| element.family }
