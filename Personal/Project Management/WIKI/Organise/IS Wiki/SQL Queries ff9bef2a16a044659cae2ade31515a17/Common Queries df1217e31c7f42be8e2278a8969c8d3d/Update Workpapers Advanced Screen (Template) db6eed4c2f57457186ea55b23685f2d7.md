# Update Workpapers Advanced Screen (Template)

Originally Added: May 18, 2021 9:28 AM
Related Tags: Go-Live-Checklist, Update, Workpapers
Updated: May 18, 2021 9:29 AM

<aside>
💡 Use case: When needing to update the Advanced Screen in the go-live-checklist

</aside>

```sql
INSERT INTO EngagementWorkpaperAdvancedScreen
            (
        [EngagementId],
        [WorkpapersAdvancedScreenTemplateId],
        [Status],
        [IsImportedFromParent]
      )
SELECT          
    Id, 
    13, -- Business Processes Template Id, 
    0, -- Not started,
    0 -- IsImportedFromParent
FROM Engagement 
WHERE InfloTemplatePackId = 4 -- International Audit;
```