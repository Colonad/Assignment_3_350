// =======================================
// 1. Schema Constraints and Indexes
// =======================================

// Unique Constraints
CREATE CONSTRAINT unique_client_id IF NOT EXISTS FOR (c:Client) REQUIRE c.id IS UNIQUE;
CREATE CONSTRAINT unique_email_address IF NOT EXISTS FOR (e:Email) REQUIRE e.address IS UNIQUE;
CREATE CONSTRAINT unique_phone_number IF NOT EXISTS FOR (p:Phone) REQUIRE p.number IS UNIQUE;
CREATE CONSTRAINT unique_ssn_number IF NOT EXISTS FOR (s:SSN) REQUIRE s.number IS UNIQUE;

// Property Indexes
CREATE INDEX client_name_index IF NOT EXISTS FOR (c:Client) ON (c.name);
CREATE INDEX email_address_index IF NOT EXISTS FOR (e:Email) ON (e.address);
CREATE INDEX phone_number_index IF NOT EXISTS FOR (p:Phone) ON (p.number);
CREATE INDEX ssn_number_index IF NOT EXISTS FOR (s:SSN) ON (s.number);

// =======================================
// 2. Sample Data Creation
// =======================================

// Create Clients
CREATE (:Client {id: 1, name: 'Alice', email: 'alice@example.com', phone: '555-0100', ssn: '123-45-6789'});
CREATE (:Client {id: 2, name: 'Bob', email: 'bob@example.com', phone: '555-0101', ssn: '123-45-6790'});
CREATE (:Client {id: 3, name: 'Charlie', email: 'charlie@example.com', phone: '555-0102', ssn: '123-45-6791'});
CREATE (:Client {id: 4, name: 'Diana', email: 'diana@example.com', phone: '555-0103', ssn: '123-45-6792'});
CREATE (:Client {id: 5, name: 'Eve', email: 'eve@example.com', phone: '555-0104', ssn: '123-45-6793'});

// Create Email Nodes
CREATE (:Email {address: 'alice@example.com'});
CREATE (:Email {address: 'bob@example.com'});
CREATE (:Email {address: 'charlie@example.com'});
CREATE (:Email {address: 'diana@example.com'});
CREATE (:Email {address: 'eve@example.com'});
CREATE (:Email {address: 'frank@example.com'});
CREATE (:Email {address: 'grace@example.com'});

// Create Phone Nodes
CREATE (:Phone {number: '555-0100'});
CREATE (:Phone {number: '555-0101'});
CREATE (:Phone {number: '555-0102'});
CREATE (:Phone {number: '555-0103'});
CREATE (:Phone {number: '555-0104'});
CREATE (:Phone {number: '555-0105'});
CREATE (:Phone {number: '555-0106'});

// Create SSN Nodes
CREATE (:SSN {number: '123-45-6789'});
CREATE (:SSN {number: '123-45-6790'});
CREATE (:SSN {number: '123-45-6791'});
CREATE (:SSN {number: '123-45-6792'});
CREATE (:SSN {number: '123-45-6793'});
CREATE (:SSN {number: '123-45-6794'});
CREATE (:SSN {number: '123-45-6795'});

// Connect Clients to Emails
MATCH (c:Client), (e:Email)
WHERE c.id = 1 AND e.address = 'alice@example.com'
CREATE (c)-[:HAS_EMAIL]->(e);

MATCH (c:Client), (e:Email)
WHERE c.id = 2 AND e.address = 'bob@example.com'
CREATE (c)-[:HAS_EMAIL]->(e);

MATCH (c:Client), (e:Email)
WHERE c.id = 3 AND e.address = 'charlie@example.com'
CREATE (c)-[:HAS_EMAIL]->(e);

MATCH (c:Client), (e:Email)
WHERE c.id = 4 AND e.address = 'diana@example.com'
CREATE (c)-[:HAS_EMAIL]->(e);

MATCH (c:Client), (e:Email)
WHERE c.id = 5 AND e.address = 'eve@example.com'
CREATE (c)-[:HAS_EMAIL]->(e);

// Shared Email Relationships
MATCH (c1:Client), (c2:Client), (e:Email)
WHERE c1.id = 1 AND c2.id = 5 AND e.address = 'frank@example.com'
CREATE (c1)-[:HAS_EMAIL]->(e), (c2)-[:HAS_EMAIL]->(e);

MATCH (c1:Client), (c2:Client), (e:Email)
WHERE c1.id = 2 AND c2.id = 3 AND e.address = 'grace@example.com'
CREATE (c1)-[:HAS_EMAIL]->(e), (c2)-[:HAS_EMAIL]->(e);

// Connect Clients to Phones
MATCH (c:Client), (p:Phone)
WHERE c.id = 1 AND p.number = '555-0100'
CREATE (c)-[:HAS_PHONE]->(p);

MATCH (c:Client), (p:Phone)
WHERE c.id = 2 AND p.number = '555-0101'
CREATE (c)-[:HAS_PHONE]->(p);

MATCH (c:Client), (p:Phone)
WHERE c.id = 3 AND p.number = '555-0102'
CREATE (c)-[:HAS_PHONE]->(p);

MATCH (c:Client), (p:Phone)
WHERE c.id = 4 AND p.number = '555-0103'
CREATE (c)-[:HAS_PHONE]->(p);

MATCH (c:Client), (p:Phone)
WHERE c.id = 5 AND p.number = '555-0104'
CREATE (c)-[:HAS_PHONE]->(p);

// Shared Phone Relationships
MATCH (c1:Client), (c2:Client), (p:Phone)
WHERE c1.id = 1 AND c2.id = 4 AND p.number = '555-0105'
CREATE (c1)-[:HAS_PHONE]->(p), (c2)-[:HAS_PHONE]->(p);

// Connect Clients to SSNs
MATCH (c:Client), (s:SSN)
WHERE c.id = 1 AND s.number = '123-45-6789'
CREATE (c)-[:HAS_SSN]->(s);

MATCH (c:Client), (s:SSN)
WHERE c.id = 2 AND s.number = '123-45-6790'
CREATE (c)-[:HAS_SSN]->(s);

MATCH (c:Client), (s:SSN)
WHERE c.id = 3 AND s.number = '123-45-6791'
CREATE (c)-[:HAS_SSN]->(s);

MATCH (c:Client), (s:SSN)
WHERE c.id = 4 AND s.number = '123-45-6792'
CREATE (c)-[:HAS_SSN]->(s);

MATCH (c:Client), (s:SSN)
WHERE c.id = 5 AND s.number = '123-45-6793'
CREATE (c)-[:HAS_SSN]->(s);

// Shared SSN Relationships
MATCH (c1:Client), (c2:Client), (s:SSN)
WHERE c1.id = 2 AND c2.id = 5 AND s.number = '123-45-6794'
CREATE (c1)-[:HAS_SSN]->(s), (c2)-[:HAS_SSN]->(s);

MATCH (c1:Client), (c2:Client), (s:SSN)
WHERE c1.id = 3 AND c2.id = 4 AND s.number = '123-45-6795'
CREATE (c1)-[:HAS_SSN]->(s), (c2)-[:HAS_SSN]->(s);


// =================================================
// Expanded Sample Data Creation For Advance Testing
// =================================================

// Create additional Clients
CREATE (:Client {id: 6, name: 'Frank', email: 'frank@example.com', phone: '555-0105', ssn: '123-45-6794'});
CREATE (:Client {id: 7, name: 'Grace', email: 'grace@example.com', phone: '555-0106', ssn: '123-45-6795'});
CREATE (:Client {id: 8, name: 'Heidi', email: 'heidi@example.com', phone: '555-0107', ssn: '123-45-6796'});
CREATE (:Client {id: 9, name: 'Ivan', email: 'ivan@example.com', phone: '555-0108', ssn: '123-45-6797'});
CREATE (:Client {id: 10, name: 'Judy', email: 'judy@example.com', phone: '555-0109', ssn: '123-45-6798'});

// Create additional Email Nodes
CREATE (:Email {address: 'heidi@example.com'});
CREATE (:Email {address: 'ivan@example.com'});
CREATE (:Email {address: 'judy@example.com'});

// Create additional Phone Nodes
CREATE (:Phone {number: '555-0107'});
CREATE (:Phone {number: '555-0108'});
CREATE (:Phone {number: '555-0109'});

// Create additional SSN Nodes
CREATE (:SSN {number: '123-45-6796'});
CREATE (:SSN {number: '123-45-6797'});
CREATE (:SSN {number: '123-45-6798'});

// Connect new Clients to Emails, Phones, and SSNs
UNWIND [
    {cid: 6, email: 'frank@example.com', phone: '555-0105', ssn: '123-45-6794'},
    {cid: 7, email: 'grace@example.com', phone: '555-0106', ssn: '123-45-6795'},
    {cid: 8, email: 'heidi@example.com', phone: '555-0107', ssn: '123-45-6796'},
    {cid: 9, email: 'ivan@example.com', phone: '555-0108', ssn: '123-45-6797'},
    {cid: 10, email: 'judy@example.com', phone: '555-0109', ssn: '123-45-6798'}
] AS row
MATCH (c:Client {id: row.cid})
MATCH (e:Email {address: row.email})
MATCH (p:Phone {number: row.phone})
MATCH (s:SSN {number: row.ssn})
CREATE (c)-[:HAS_EMAIL]->(e)
CREATE (c)-[:HAS_PHONE]->(p)
CREATE (c)-[:HAS_SSN]->(s);

// Introduce shared relationships to increase connectivity
// Shared Email among multiple users
MATCH (c:Client), (e:Email)
WHERE c.id IN [6, 7, 8] AND e.address = 'shared@example.com'
CREATE (c)-[:HAS_EMAIL]->(e);

// Shared Phone among multiple users
MATCH (c:Client), (p:Phone)
WHERE c.id IN [9, 10] AND p.number = '555-shared'
CREATE (c)-[:HAS_PHONE]->(p);

// Shared SSN among multiple users
MATCH (c:Client), (s:SSN)
WHERE c.id IN [8, 9] AND s.number = '123-shared'
CREATE (c)-[:HAS_SSN]->(s);

// Additional complex shared relationships
CREATE (e:Email {address: 'shared@example.com'}), (p:Phone {number: '555-shared'}), (s:SSN {number: '123-shared'});
