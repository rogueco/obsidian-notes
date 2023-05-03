# Random Weird Issues

# Injest

## Loading Spinner - Set Details

**Issue**: This is because the `ChartOfAccountsTemplateId`   has not been set on the creation on the engagement.

- If the `ChartOfAccountsTemplateId`   has been set in the DB ensure you run the `TemplateLoader.cs` found in `(ION/src/Inflo.Consoles.TemplateLoader/Inflo.Consoles.TemplateLoader.csproj)`

![Random%20Weird%20Issues%20a3e7aa7c36b540f3a2c1645bc2ab1675/Untitled.png](Personal/Project%20Management/IS%20Wiki/Random%20Weird%20Issues%20a3e7aa7c36b540f3a2c1645bc2ab1675/Untitled.png)

```sql
select * from Engagement;
UPDATE Engagement SET ChartOfAccountsTemplateId = 1 WHERE Id = EngagementId;
```