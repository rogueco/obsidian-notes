

## Members NOT APP Registered VIA CLUB  
```sql
declare @AppName varchar(50) = 'MyGolf'
SELECT DISTINCT M.MemberId, M.CentralMemberCode, C.Name AS 'Home Club Name', M.FirstName, M.LastName, CM.Email, CM.Phone_Mobile AS Mobile  
FROM Member M  
    JOIN CMember CM ON M.MemberId = CM.MemberId AND CM.ClubId = M.Clubno  
    JOIN Club C ON M.Clubno = C.ClubID  
LEFT JOIN Passport P on M.MemberId = P.MemberId  
LEFT JOIN MobileDevice MD on P.PassportID = MD.PassportId  
WHERE M.Clubno = 30349  
  AND M.Date_resigned IS NULL  
  AND CM.DeletedDate IS NULL  
  AND CM.Date_Resigned IS NULL  
  AND MD.DeletedDate IS NULL  
--   AND (@AppName IS NULL OR MD.AppName = @AppName)  
AND MD.MobileDeviceId IS NULL
```


## Members APP Registered VIA CLUB  
```sql
declare @AppName varchar(50) = 'MyGolf'  
SELECT DISTINCT M.MemberId, M.CentralMemberCode, C.Name AS 'Home Club Name', M.FirstName, M.LastName, CM.Email, CM.Phone_Mobile AS Mobile  
FROM Member M  
    JOIN CMember CM ON M.MemberId = CM.MemberId AND CM.ClubId = M.Clubno  
    JOIN Club C ON M.Clubno = C.ClubID  
JOIN Passport P on M.MemberId = P.MemberId  
JOIN MobileDevice MD on P.PassportID = MD.PassportId  
WHERE M.Clubno = 30349  
  AND M.Date_resigned IS NULL  
  AND CM.DeletedDate IS NULL  
  AND CM.Date_Resigned IS NULL  
  AND MD.DeletedDate IS NULL  
  AND (@AppName IS NULL OR MD.AppName = @AppName)
```