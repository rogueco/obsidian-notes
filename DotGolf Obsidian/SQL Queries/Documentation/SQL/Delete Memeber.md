#documentation #regularQueries #sql


## Delete Member Record

If you need to delete a member record make sure you

```sql
BEGIN TRANSACTION
UPDATE CMember
SET DeletedDate = GETDATE()
WHERE CentralMemberCode = ''
ROLLBACK TRANSACTION
-- COMMIT TRANSACTION
```

