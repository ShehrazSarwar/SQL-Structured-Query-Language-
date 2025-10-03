-- ISDATE(Value)  -> Check if a value is a date.

SELECT
ISDATE('123') AS DateCheck1,
ISDATE('2025-10-03') AS DateCheck2,
ISDATE('20-03-2025') AS DateCheck3,
ISDATE('2025') AS DateCheck4,
ISDATE('08') AS DateCheck5