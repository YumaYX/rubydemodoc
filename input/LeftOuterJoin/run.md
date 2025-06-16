This Ruby code uses the `ys1` gem to perform a **Left Outer Join** between two CSV files.  
Specifically, it uses the `YS1::LeftOuterJoin::CLI` class to read two CSVs:

- A **left table** (e.g., `users.csv`) that contains a primary key (`id`)
- A **right table** (e.g., `orders.csv`) that references the left table's key (`user_id`)

The join operation ensures that all records from the left table are preserved, even if there is no matching row in the right table. If matches are found, the rows from the right table are merged accordingly.

```sh
$ cat users.csv
id,name
1,Alice
2,Bob
3,Charlie
$ 
$ cat orders.csv
id,user_id,product
1,1,Book
2,1,Pen
3,2,Notebook
$ 
```

## Use Case

- **Merging CSV files** by a common key.
- **ETL (Extract, Transform, Load)** operations where preserving left-side data is important.
- **Quick data analysis** or preprocessing before loading into a database or visualization tool.
- **Command-line automation** for data joins without writing full scripts.
