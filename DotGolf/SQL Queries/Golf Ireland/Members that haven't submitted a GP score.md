```sql
SELECT M.MemberId, S.IsCompetitionScore  
FROM Member M  
JOIN Score S ON M.MemberId = S.MemberID  
JOIN Cmember CM ON M.MemberId = CM.MemberId AND M.Clubno = CM.ClubId  
                   WHERE S.DeletedDate IS NULL AND CM.Date_Resigned IS NULL  
GROUP BY M.MemberId, S.IsCompetitionScore  
HAVING COUNT(S.IsCompetitionScore) = 0
```