```sql
-- Average score – Male/Female and Combined. 18hole scores  
-- Average handicap – Male/Female and Combined, end of year 21 and 22 – 31st December  
-- Average age - Male/Female and Combined, end of year 21 and 22 – 31st December  
-- Top 3 Counties that input scores through WHS –we are assuming you don't mean scores input direct to WHS by counties but want to include scores that come to WHS via an ISV.  Anticipating the question 'if my county is not in top 3 then where are we?' we would be thinking to give you a list of all playing counties, with the number of scores input for members of clubs in that county, wherever those rounds were played, in the 2 years 2021 and 2022, for male and female members.  (NB the counts would exclude rounds played by active iGolfers, but include rounds attributed to active members played whilst they were previously an active iGolfer.) Yes that is fine.  
-- Top 3 Clubs that input scores through WHS - we are assuming you don't mean scores input direct to WHS by clubs, but want to include scores that come to WHS via an ISV.  Anticipating the question 'if my club is not in top 3 then where are we?' we would be thinking to give you a list of all clubs, with the number of scores input for members, wherever those rounds were played, in the 2 years 2021 and 2022, for male and female members.  (NB the counts would exclude rounds played by active iGolfers, but include rounds attributed to active members played whilst they were previously an active iGolfer.) Yes that’s fine  
-- Most popular tee set - how are you defining most popular?  Do you mean the most-played individual marker at any individual course?  Or are you looking for some kind of broad analysis of Red/Yellow/White, across the whole country, across the whole year?  If the latter, this analysis could be thwarted by inconsistent naming conventions and colours?  It would seem intuitively most likely the answers would be Red for female players and Yellow for male players.  So if it seems that obvious have we missed the point?  We are unsure what fact or comparison you are looking to expose here, and your guidance would be appreciated... Most played tee-set, this a very basic comparison between tee-sets, understandably there will be skewed data based on courses with varying tee times however the most common is red/yellow/white.  
  
  
declare @FromDate datetime = '2021-01-01'  
declare @ToDate datetime = '2021-12-31'  
-- Average Scores  
-- Male/Female  
SELECT M.Gender, AVG(ALL S.Score) AS 'Average Score Mens' FROM Score S JOIN NZCRData ND on S.Markerid = ND.MarkerID JOIN Member M ON S.MemberID = M.MemberId WHERE S.PlayDate BETWEEN @FromDate AND @ToDate AND S.DeletedDate IS NULL AND ND.ninehole ='N' GROUP BY M.Gender  
-- Combined  
SELECT AVG(ALL S.Score) AS 'Average Score Combined' FROM Score S JOIN NZCRData ND on S.Markerid = ND.MarkerID WHERE S.PlayDate BETWEEN @FromDate AND @ToDate AND S.DeletedDate IS NULL AND ND.ninehole ='N'  
  
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED  
-- Average Age  
-- By Gender  
SELECT M.Gender, AVG(ALL (0 + Convert(Char(8),@ToDate,112) - Convert(Char(8),M.DOB,112)) / 10000) FROM Member M JOIN Cmember CM ON M.MemberId = CM.MemberId WHERE (CM.Date_Started <= @ToDate OR CM.Date_Started IS NULL) AND (CM.Date_Resigned IS NULL OR CM.Date_Resigned BETWEEN @FromDate AND @ToDate OR CM.Date_Resigned > @FromDate) AND M.DOB IS NOT NULL GROUP BY GENDER  
-- Combined  
SELECT AVG(ALL (0 + Convert(Char(8),@ToDate,112) - Convert(Char(8),M.DOB,112)) / 10000) FROM Member M JOIN Cmember CM ON M.MemberId = CM.MemberId WHERE (CM.Date_Started <= @ToDate OR CM.Date_Started IS NULL) AND (CM.Date_Resigned IS NULL OR CM.Date_Resigned BETWEEN @FromDate AND @ToDate OR CM.Date_Resigned > @FromDate) AND M.DOB IS NOT NULL  
  
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED  
declare @FromDate datetime = '2022-01-01'  
declare @ToDate datetime = '2022-12-31'  
-- Average handicap – Male/Female and Combined, end of year 21 and 22 – 31st December  
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
  
  
SELECT * FROM Member M WHERE M.MemberId = 3587377  
  
-- Top 3 Counties that input scores through WHS  
-- –we are assuming you don't mean scores input direct to WHS by counties but want to include scores that come to WHS via an ISV.  
-- Anticipating the question 'if my county is not in top 3 then where are we?' we would be thinking to give you a list of all playing counties,  
-- with the number of scores input for members of clubs in that county, wherever those rounds were played, in the 2 years 2021 and 2022, for male and female members.  
-- (NB the counts would exclude rounds played by active iGolfers, but include rounds attributed to active members played whilst they were previously an active iGolfer.) Yes that is fine.  
  
declare @FromDate datetime = '2021-01-01'  
declare @ToDate datetime = '2021-12-31'  
SELECT  
    R.Region AS 'County Name',  
    COUNT(S.Score) AS 'Number of Submitted Scores'  
FROM Score S  
    JOIN NZCRData ND on S.Markerid = ND.MarkerID  
    JOIN Course CO ON ND.CourseID = CO.CourseID  
    JOIN Club C ON CO.Clubid = C.ClubID  
    JOIN Region R ON C.RegionId = R.Regionid  
WHERE S.PlayDate BETWEEN @FromDate AND @ToDate AND S.DeletedDate IS NULL  
  AND C.AssociationId = 1000  
GROUP BY R.Region  
ORDER BY COUNT(S.Score) DESC  
  
  
-- Top 3 Clubs that input scores through WHS -  
-- we are assuming you don't mean scores input direct to WHS by clubs, but want to include scores that come to WHS via an ISV.  
-- Anticipating the question 'if my club is not in top 3 then where are we?' we would be thinking to give you a list of all clubs,  
-- with the number of scores input for members, wherever those rounds were played, in the 2 years 2021 and 2022, for male and female members.  
-- (NB the counts would exclude rounds played by active iGolfers, but include rounds attributed to active members played whilst they were previously an active iGolfer.) Yes that’s fine  
declare @FromDate datetime = '2022-01-01'  
declare @ToDate datetime = '2022-12-31'  
SELECT  
    C.Name AS 'Club Name',  
    COUNT(S.Score) AS 'Number of Submitted Scores'  
FROM Score S  
         JOIN NZCRData ND on S.Markerid = ND.MarkerID  
         JOIN Course CO ON ND.CourseID = CO.CourseID  
         JOIN Club C ON CO.Clubid = C.ClubID  
         JOIN Region R ON C.RegionId = R.Regionid  
WHERE S.PlayDate BETWEEN @FromDate AND @ToDate AND S.DeletedDate IS NULL  
  AND C.AssociationId = 1000  
GROUP BY C.Name  
ORDER BY COUNT(S.Score) DESC  
  
-- Most popular tee set - how are you defining most popular?  
-- Do you mean the most-played individual marker at any individual course?  
-- Or are you looking for some kind of broad analysis of Red/Yellow/White, across the whole country, across the whole year?  
-- If the latter, this analysis could be thwarted by inconsistent naming conventions and colours?  It would seem intuitively most likely the answers would be Red for female players and Yellow for male players.  
-- So if it seems that obvious have we missed the point?  We are unsure what fact or comparison you are looking to expose here, and your guidance would be appreciated...  
-- Most played tee-set, this a very basic comparison between tee-sets, understandably there will be skewed data based on courses with varying tee times however the most common is red/yellow/white.  
  
declare @FromDate datetime = '2021-01-01'  
declare @ToDate datetime = '2021-12-31'  
SELECT  
    SUM(CASE WHEN ND.Marker LIKE '%RED%' THEN 1 END) AS 'RED MARKER',  
    SUM(CASE WHEN ND.Marker LIKE '%WHITE%' THEN 1 END) AS 'WHITE MARKER',  
    SUM(CASE WHEN ND.Marker LIKE '%BLUE%' THEN 1 END) AS 'BLUE MARKER',  
    SUM(CASE WHEN ND.Marker LIKE '%GREEN%' THEN 1 END) AS 'GREEN MARKER',  
    SUM(CASE WHEN ND.Marker LIKE '%YELLOW%' THEN 1 END) AS 'YELLOW MARKER',  
    SUM(CASE WHEN ND.Marker LIKE '%BLACK%' THEN 1 END) AS 'BLACK MARKER',  
    SUM(CASE WHEN ND.Marker LIKE '%PINK%' THEN 1 END) AS 'PINK MARKER',  
    SUM(CASE WHEN ND.Marker NOT LIKE '%RED%'  
                      AND ND.Marker NOT LIKE '%WHITE%'  
                      AND ND.Marker NOT LIKE '%BLUE%'  
                      AND ND.Marker NOT LIKE '%GREEN%'  
                      AND ND.Marker NOT LIKE '%BLACK%'  
                      AND ND.Marker NOT LIKE '%PINK%'  
                      AND ND.Marker NOT LIKE '%YELLOW%' THEN 1 END) AS 'OTHER'  
FROM Score S  
         JOIN NZCRData ND on S.Markerid = ND.MarkerID  
         JOIN Course CO ON ND.CourseID = CO.CourseID  
         JOIN Club C ON CO.Clubid = C.ClubID  
WHERE S.PlayDate BETWEEN @FromDate AND @ToDate AND S.DeletedDate IS NULL  
  AND S.CapturedByThirdPartyId IS NOT NULL  
  AND C.AssociationId = 1000  
AND ND.Gender = 'W'
```