/* Create a new table called persons
with columns: id, person_name, birth_date, and phone.

CONSTRAINTS: 
UNIQUE -> no duplicates allowed.
IDENTITY(1,1) -> auto-increment numbers, just like AUTO_INCREMENT in MySql.
PRIMARY KEY -> unique row identifier.
FOREIGN KEY -> enforces relationships.
DEFAULT -> automatic fallback value.
CHECK -> validates a condition.
*/

CREATE TABLE persons(
	id INT,
	person_name VARCHAR(50) NOT NULL,
	birth_date DATE,
	phone VARCHAR(15) NOT NULL,

	CONSTRAINT uq_persons_phone UNIQUE (phone),
	CONSTRAINT pk_persons_id PRIMARY KEY (id)
)