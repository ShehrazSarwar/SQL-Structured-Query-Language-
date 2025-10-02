-- REPLACE(col or val, old, new)

-- Remove dashes (-) from a phone number
SELECT
'123-456-7890' AS phone,
REPLACE('123-456-7890','-','') AS clean_phone
--REPLACE('123-456-7890','-','/') AS clean_phone

-- Replace File Extence from txt to csv
SELECT
'file.txt' AS txt_file,
REPLACE('file.txt','.txt','.csv') AS converted_csv