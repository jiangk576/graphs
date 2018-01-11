export FILEPATH="file:C:/Users/moore/Dropbox/graphs/prods.csv"

// Products, Customers, Reviews.

	// Uniqueness constraints.
CREATE CONSTRAINT ON (c:Product) ASSERT c.id IS UNIQUE;
CREATE CONSTRAINT ON (c:Customer) ASSERT c.id IS UNIQUE;
CREATE CONSTRAINT ON (c:Review) ASSERT c.id IS UNIQUE;
CREATE CONSTRAINT ON (c:Micro) ASSERT c.name IS UNIQUE;
CREATE CONSTRAINT ON (c:Sub) ASSERT c.name IS UNIQUE;
CREATE CONSTRAINT ON (c:Cat) ASSERT c.name IS UNIQUE;
CREATE CONSTRAINT ON (c:Group) ASSERT c.name IS UNIQUE;


	// Load.
USING PERIODIC COMMIT
LOAD CSV WITH HEADERS 
FROM {FILEPATH} AS line
CREATE (product:Product { id: line.ASIN, title: line.title, sales_rank: line.sales_rank, status: line.status, group: line.group, reviews: line.reviews, avg_rating: line.avg_rating, cats: line.cats})

LOAD CSV WITH HEADERS
FROM "file:///C:/Users/moore/Dropbox/graphs/prods.csv" AS line
CREATE (product:Product { id: line.ASIN});


C:\Users\moore\AppData\Roaming\Neo4j Desktop\Application\neo4jDatabases\database-ed4e563a-2161-4eb2-b19b-6606c1c6050b\installation-3.3.1\import

LOAD CSV WITH HEADERS FROM  "file:///prods.csv" AS line
WITH line
LIMIT 1
RETURN line;


Store import files in the import folder for Neo
LOAD CSV WITH HEADERS FROM  "file:///prods.csv" AS line
CREATE (product:Product { id: line.ASIN});

