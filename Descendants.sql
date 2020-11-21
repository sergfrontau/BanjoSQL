;WITH cte AS (
    SELECT Id,
	ParentId,  
	':' + CAST(id AS VARCHAR(max)) + ':' as Hierarchy,
	HasCircularReference = 0
    FROM Person 
    WHERE ParentId = 2

    UNION ALL

    SELECT p.Id,
	p.ParentId,
	Hierarchy + CAST(p.Id AS VARCHAR(255)) + ':' as Hierarchy,
	CASE WHEN [Hierarchy] LIKE '%:' + CAST(p.Id AS VARCHAR(255)) + ':%' THEN 1 ELSE 0 END AS HasCircularReference
    FROM Person p
    INNER JOIN cte c ON c.Id = p.ParentId and c.HasCircularReference = 0
)
SELECT Id, ParentId, Hierarchy AS Hierarchy, HasCircularReference FROM cte 
ORDER BY Hierarchy