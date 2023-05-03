```sql

  
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED  
DECLARE @AsOF DATE = '2023-01-01'  
SELECT  
    M.CentralMemberCode [MembershipNumber],  
    M.FirstName,  
    M.LastName,  
    M.Gender,  
    C.Name [ClubName],  
       CASE WHEN SecondaryClub.ClubId IS NOT NULL THEN (SELECT Name FROM Club WHERE ClubID = SecondaryClub.ClubId) END [SecondaryClub1],  
       CASE WHEN SecondaryClub_2.ClubId IS NOT NULL THEN (SELECT Name FROM Club WHERE ClubID = SecondaryClub_2.ClubId) END [SecondaryClub2],  
       CASE WHEN SecondaryClub_3.ClubId IS NOT NULL THEN (SELECT Name FROM Club WHERE ClubID = SecondaryClub_2.ClubId) END [SecondaryClub3],  
    R.Region [PlayingCounty],  
    M.DOB,  
    (0 + Convert(Char(8),@AsOF,112) - Convert(Char(8),M.DOB,112)) / 10000 [Age],  
    M.NZGA_Handicap [Handicap],  
    (SELECT TOP 1 S.PlayDate FROM Score S WHERE S.MemberID = M.MemberId AND S.DeletedDate IS NULL) [LastPlayed]  
FROM Member M  
    JOIN Cmember CM ON M.MemberId = CM.MemberId AND M.Clubno = CM.ClubId  
    JOIN Club C ON CM.ClubId = C.ClubID  
    LEFT JOIN Cmember SecondaryClub ON M.MemberId = SecondaryClub.MemberId AND M.Clubno != CM.ClubId AND SecondaryClub.Date_Resigned IS NULL  
    LEFT JOIN Cmember SecondaryClub_2 ON M.MemberId = SecondaryClub_2.MemberId AND M.Clubno != CM.ClubId AND SecondaryClub_2.Date_Resigned IS NULL  
    LEFT JOIN Cmember SecondaryClub_3 ON M.MemberId = SecondaryClub_3.MemberId AND M.Clubno != CM.ClubId AND SecondaryClub_3.Date_Resigned IS NULL  
    LEFT JOIN Region R ON C.Regionid = R.Regionid  
WHERE CM.Date_Resigned IS NULL AND CM.DeletedDate IS NULL  
ORDER BY CM.Surname
```