**Data Structures:**

*   **Hash:** A key-value pair data structure, like `{ name: "Alice", age: 25, city: "Tokyo" }`.  Keys are unique identifiers, and values are associated with those keys.

**Code Explanation:**

*   **Dynamic Class Creation:**  The `create_dynamic_class` function takes a hash as input and creates a Ruby class that can dynamically define attributes based on the hash.
*   **Attribute Accessors:** Inside the class, `attr_accessor key.to_sym` creates getter and setter methods for each key in the hash.  `key.to_sym` converts the key to a symbol, which is the preferred way to represent keys in Ruby.
*   **Initialization:** The `initialize` method is called when a new object of the class is created.  It iterates through the hash and sets each key as an instance variable, using the `@` prefix (e.g., `@name`, `@age`).

**Object Usage:**

*   **`obj = kls.new`:** Creates a new object (instance) of the dynamic class, using the `new` method.
*   **`obj.name`:** Accesses the `name` attribute of the object.
*   **`obj.age`:** Accesses the `age` attribute.
*   **`obj.city`:** Accesses the `city` attribute.
