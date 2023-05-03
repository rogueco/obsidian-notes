# Add User Roles Identity

Originally Added: May 20, 2021 2:04 PM
Related Tags: Identity, Nuke
Updated: May 20, 2021 3:08 PM

<aside>
💡 Use case: When Identity Server has been reset

</aside>

```sql
DECLARE @IdentityUserId AS VARCHAR(100)
SET @IdentityUserId =  (Select IdentityUserId from [Inflo].[dbo].[AspNetUsers] where id = 3)
Insert into InfloIdentity.dbo.IdentityUserRole (IdentityUserId,Role) values (@IdentityUserId,220), (@IdentityUserId,229),(@IdentityUserId,233),(@IdentityUserId,239),(@IdentityUserId,250)
```