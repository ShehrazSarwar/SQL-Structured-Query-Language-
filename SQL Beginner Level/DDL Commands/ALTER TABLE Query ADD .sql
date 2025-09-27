-- Add a new column called email to the persons table

ALTER TABLE persons
ADD email VARCHAR(50) NOT NULL,
user_password VARCHAR(50) NOT NULL, -- For multiple cols
CONSTRAINT uq_persons_email UNIQUE (email) -- For constraint

-- when adding only a constraint:
-- ALTER TABLE... ADD CONSTRAINT ...

/* IN MySql we use AFTER -> ADD email VARCHAR(50) AFTER person_name
   Inorder to add column after person_name location but in SQL
   Server AFTER keyword doesn't exist. */

SELECT *
FROM persons