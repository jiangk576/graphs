
// Products, Customers, Reviews.

	// always test the CSV first look for gaps and spaces

LOAD CSV WITH HEADERS FROM  "file:///prods.csv" AS line
WITH line
LIMIT 1
RETURN line;


	// make sure to know where to store the csv file

C:\Users\moore\AppData\Roaming\Neo4j Desktop\Application\neo4jDatabases\database-4fbf7e0f-fd75-4a99-8f23-9edc40981ae5\installation-3.3.1\import


	// Uniqueness constraints.

CREATE CONSTRAINT ON (c:Product) ASSERT c.id IS UNIQUE;

	// load data
	// products

USING PERIODIC COMMIT
LOAD CSV WITH HEADERS FROM  "file:///prods.csv" AS line
CREATE (product:Product { id: line.ASIN, title: line.title,
status: line.status, sales_rank: line.sales_rank, group: line.group,
avg_rating: line.avg_rating, cats: line.cats});


	// load data
	// co-purchases

	// first test the file

	// then load the data - keep row counts to around 1,000,000


CREATE CONSTRAINT ON (r:co_pur) ASSERT r.id IS UNIQUE;
USING PERIODIC COMMIT
LOAD CSV WITH HEADERS FROM  "file:///bought.csv" AS line
MATCH (product:Product { id: line.asin})
MERGE (co_product:Product { id: line.co_pur})
MERGE (product)-[r:co_pur]->(co_product);


USING PERIODIC COMMIT
LOAD CSV WITH HEADERS FROM  "file:///bought1.csv" AS line
MATCH (product:Product { id: line.asin})
MERGE (co_product:Product { id: line.co_pur})
MERGE (product)-[r:co_pur]->(co_product);

USING PERIODIC COMMIT
LOAD CSV WITH HEADERS FROM  "file:///bought2.csv" AS line
MATCH (product:Product { id: line.asin})
MERGE (co_product:Product { id: line.co_pur})
MERGE (product)-[r:co_pur]->(co_product);

USING PERIODIC COMMIT
LOAD CSV WITH HEADERS FROM  "file:///bought3.csv" AS line
MATCH (product:Product { id: line.asin})
MERGE (co_product:Product { id: line.co_pur})
MERGE (product)-[r:co_pur]->(co_product);


LOAD CSV WITH HEADERS FROM  "file:///cats.csv" AS line
WITH line
LIMIT 1
RETURN line;


LOAD CSV WITH HEADERS FROM  "file:///reviews.csv" AS line
WITH line
LIMIT 1
RETURN line;

LOAD CSV WITH HEADERS FROM  "file:///sims.csv" AS line
WITH line
LIMIT 1
RETURN line;

CREATE CONSTRAINT ON (r:similar) ASSERT r.id IS UNIQUE;
USING PERIODIC COMMIT
LOAD CSV WITH HEADERS FROM  "file:///sims.csv" AS line
MATCH (product:Product { id: line.prod})
MATCH (co_product:Product { id: line.sim_prod})
MERGE (product)-[r:similar]->(co_product);

USING PERIODIC COMMIT
LOAD CSV WITH HEADERS FROM  "file:///sims1.csv" AS line
MATCH (product:Product { id: line.prod})
MATCH (co_product:Product { id: line.sim_prod})
MERGE (product)-[r:similar]->(co_product);


CREATE CONSTRAINT ON (r:review) ASSERT r.id IS UNIQUE;
CREATE CONSTRAINT ON (c:Customer) ASSERT c.id IS UNIQUE;
CREATE CONSTRAINT ON (r:reviewed) ASSERT r.id IS UNIQUE;
CREATE CONSTRAINT ON (r:bought) ASSERT r.id IS UNIQUE;


USING PERIODIC COMMIT
LOAD CSV WITH HEADERS FROM  "file:///reviews.csv" AS line
MATCH (product:Product { id: line.ASIN})
CREATE (review:Review { id: line.ASIN, date: line.date, customer: line.customer, rating: line.rating, votes: line.votes, helpful: line.helpful})
MERGE (customer:Customer {id: line.customer})
MERGE (customer)-[r:reviewed]->(review)
MERGE (customer)-[f:bought]->(product)
MERGE (product)-[e:review]->(review);


CREATE CONSTRAINT ON (r:belongs_to) ASSERT r.name IS UNIQUE;
CREATE CONSTRAINT ON (r:is_micro_cat) ASSERT r.name IS UNIQUE;
CREATE CONSTRAINT ON (r:part_of) ASSERT r.name IS UNIQUE;
CREATE CONSTRAINT ON (r:in_group) ASSERT r.name IS UNIQUE;


USING PERIODIC COMMIT
LOAD CSV WITH HEADERS FROM  "file:///cats.csv" AS line
MATCH (product:Product { id: line.ASIN})
MERGE (micro:Micro {name: line.micro})
MERGE (sub:Sub {name: line.sub})
MERGE (cat:Cat {name: line.cat})
MERGE (group:Group {name: line.group})

MERGE (product)-[a:belongs_to]->(micro)
MERGE (micro)-[b:is_micro_cat]->(sub)
MERGE (sub)-[c:part_of]->(cat)
MERGE (cat)-[d:in_group]->(group);

