This Ruby code snippet demonstrates how different array-like literal notations (`%w`, `%W`, `%i`, and `%I`) function in Ruby, particularly regarding string interpolation and symbol creation.

### `%w(a b c "#{str}")`

Creates an array of strings **without** interpolation.
**Result:** `["a", "b", "c", "\"#{str}\""]`

### `%W(a b c "#{str}")`

Creates an array of strings **with** interpolation.
**Result:** `["a", "b", "c", "ruby"]`

### `%i(a b c "#{str}")`

Creates an array of symbols **without** interpolation.
**Result:** `[:a, :b, :c, :"\"#{str}\""]`

### `%I(a b c "#{str}")`

Creates an array of symbols **with** interpolation.
**Result:** `[:a, :b, :c, :"ruby"]`

