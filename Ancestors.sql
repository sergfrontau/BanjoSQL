;WITH cte AS (
    SELECT Id,
	ParentId,  
	':' + CAST(parentid AS VARCHAR(max)) + ':' as Hierarchy,
	HasCircularReference = 0
    FROM Person 
    WHERE Id = 8

    UNION ALL

    SELECT p.Id,
	p.ParentId,
	Hierarchy + CAST(p.parentId AS VARCHAR(255)) + ':' as Hierarchy,
	CASE WHEN [Hierarchy] LIKE '%:' + CAST(p.parentId AS VARCHAR(255)) + ':%' THEN 1 ELSE 0 END AS HasCircularReference
    FROM Person p
    INNER JOIN cte c ON p.Id = c.ParentId and c.HasCircularReference = 0 
	
)
SELECT Id, ParentId, Hierarchy AS Hierarchy, HasCircularReference FROM cte 
where Id <> 8
ORDER BY Hierarchy