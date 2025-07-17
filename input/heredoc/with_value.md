This Ruby code snippet demonstrates string interpolation and heredoc syntax. The code assigns the string 'ruby' to the variable `value`. Then, it uses a heredoc (`<<~EOL ... EOL`) to create a multi-line string `doc`. Inside the heredoc, it uses string interpolation (`#{value}`) to insert the value of the `value` variable into the `doc` string.  The resulting `doc` string will be "ruby".



```ruby
value = 'ruby'
doc = <<~EOL
 #{value}
EOL
```




