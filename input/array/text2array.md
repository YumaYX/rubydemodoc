The cheapest way to convert text into a Ruby array (?)
 
```sh
cat <<'EOF' > t2a.rb
text = <<~TEXT
a
b
c
TEXT

lines = text.lines.map(&:chomp)
EOF

vim t2a.rb
```
