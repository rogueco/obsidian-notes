```sql
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED  
declare @FromDate datetime = '2022-01-01'  
declare @ToDate datetime = '2022-12-31'    
SELECT  
    M.CentralMemberCode,  
    M.MemberId,  
    M.Gender,  
       CASE WHEN (SELECT TOP 1 S.PlayDate FROM Score S WHERE M.MemberId = S.MemberID AND S.PlayDate > @ToDate ORDER BY S.PlayDate ASC) IS NOT NULL THEN (SELECT TOP 1 S.NZGA_Handicap FROM Score S WHERE M.MemberId = S.MemberID AND S.PlayDate > @ToDate ORDER BY S.PlayDate ) ELSE M.NZGA_Handicap END  
FROM Member M  
    JOIN Cmember CM ON M.MemberId = CM.MemberId  
WHERE (CM.Date_Started <= @ToDate OR CM.Date_Started IS NULL)  
  AND (CM.Date_Resigned IS NULL OR CM.Date_Resigned BETWEEN @FromDate AND @ToDate OR CM.Date_Resigned > @FromDate)  
  AND M.NZGA_Handicap IS NOT NULL  
GROUP BY M.MemberId, M.Gender, M.CentralMemberCode, M.NZGA_Handicap
```

