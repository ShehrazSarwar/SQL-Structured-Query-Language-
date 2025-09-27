/* Delete the column phone from the table persons
   Before dropping phone column we need to drop its constraint first
   This is because phone have constraint called UNIQUE */

-- Step 1: Drop the constraint
ALTER TABLE persons
DROP CONSTRAINT uq_persons_phone

-- Step 2: Drop the column
ALTER TABLE persons
DROP COLUMN phone

-- For multiple
-- ALTER TABLE persons
-- DROP COLUMN phone, user_password

SELECT *
FROM persons