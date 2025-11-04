/* ==============================================================================
   Fragementations
============================================================================== */

-- Retrieve index fragmentation statistics for the current database
SELECT 
    tbl.name AS TableName,
    idx.name AS IndexName,
    s.avg_fragmentation_in_percent,
    s.page_count
FROM sys.dm_db_index_physical_stats(DB_ID(), NULL, NULL, NULL, 'LIMITED') AS s
INNER JOIN sys.tables tbl 
ON s.object_id = tbl.object_id
INNER JOIN sys.indexes AS idx 
ON idx.object_id = s.object_id
AND idx.index_id = s.index_id
ORDER BY s.avg_fragmentation_in_percent DESC;

-- Reorganize the index (lightweight defragmentation)
ALTER INDEX idx_DBCustomers_CS
ON Sales.DBCustomers REORGANIZE;

-- Rebuild the index (full rebuild, more resource-intensive)
ALTER INDEX idx_DBCustomers_CS
ON Sales.DBCustomers REBUILD;