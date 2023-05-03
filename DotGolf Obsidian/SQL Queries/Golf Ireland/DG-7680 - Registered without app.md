	

```sql
-- SELECT COUNT(Distinct PC.PassportID)  
SELECT DISTINCT PC.PassportID, M.CentralMemberCode [Membership Number], C.Name, CM.FirstName, Cm.Surname, CM.Email  
FROM PassportCredential PC  
         JOIN Passport P on P.PassportID = PC.PassportID  
         JOIN member M ON P.MemberId = M.MemberId  
         JOIN CMember CM on M.MemberId = CM.MemberId AND M.Clubno = CM.ClubId  
        JOIN Club C ON M.Clubno = C.ClubID  
         LEFT JOIN MobileDevice MD on P.PassportID = MD.PassportId  
WHERE MD.PassportId IS NULL  
  AND MD.DeletedDate IS NULL  
  AND CM.DeletedDate IS NULL  
  AND CM.Date_Resigned IS NULL  
  AND P.DeletedDate IS NULL  
  AND P.MemberId IS NOT NULL  
  AND PC.DeletedDate IS NULL  
  AND M.Date_resigned IS NULL  
  AND M.Deleted IS NULL;
```

