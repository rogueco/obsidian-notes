```sql
  
-- R&A Data Request  
  
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED  
declare @FromDate datetime = '2022-01-01'  
declare @ToDate datetime = '2022-12-31'  
SELECT  
    S.WHSScoreUID,  
    M.MemberId AS 'Internal Number',  
    CM.MemberCode AS 'Membership Number',  
    M.Gender,  
    S.PlayDate AS 'Date Round Played',  
    CASE WHEN S.IsCompetitionScore = 1 THEN 'Competition' ELSE 'General Play' END AS 'Score Type',  
    S.ThirdPartyCompetitions AS 'Competition Id',  
    -- TODO: Need to figure out comp name  
    S.Stableford,  
    CASE WHEN S.Stableford = 1 THEN 'Stableford' ELSE 'Stroke Play' END AS 'Format of Play',  
    C.Name AS 'Course Name',  
    ND.Marker AS 'Tees Played',  
    CASE WHEN ND.ninehole = 'Y' THEN 9 ELSE 18 END AS '9-hole or 18-hole Round',  
    (CASE WHEN S.Hole1 > 0  THEN 1 ELSE 0 END +  
        CASE WHEN S.Hole2 > 0  THEN 1 ELSE 0 END +  
        CASE WHEN S.Hole3 > 0  THEN 1 ELSE 0 END +  
        CASE WHEN S.Hole4 > 0  THEN 1 ELSE 0 END +  
        CASE WHEN S.Hole5 > 0  THEN 1 ELSE 0 END +  
        CASE WHEN S.Hole6 > 0  THEN 1 ELSE 0 END +  
        CASE WHEN S.Hole7 > 0  THEN 1 ELSE 0 END +  
        CASE WHEN S.Hole8 > 0  THEN 1 ELSE 0 END +  
        CASE WHEN S.Hole9 > 0  THEN 1 ELSE 0 END +  
        CASE WHEN S.Hole10 > 0  THEN 1 ELSE 0 END +  
        CASE WHEN S.Hole11 > 0  THEN 1 ELSE 0 END +  
        CASE WHEN S.Hole12 > 0  THEN 1 ELSE 0 END +  
        CASE WHEN S.Hole13 > 0  THEN 1 ELSE 0 END +  
        CASE WHEN S.Hole14 > 0  THEN 1 ELSE 0 END +  
        CASE WHEN S.Hole15 > 0  THEN 1 ELSE 0 END +  
        CASE WHEN S.Hole16 > 0  THEN 1 ELSE 0 END +  
        CASE WHEN S.Hole17 > 0  THEN 1 ELSE 0 END +  
        CASE WHEN S.Hole18 > 0  THEN 1 ELSE 0 END)  
        AS 'Number of Holes Played',  
    ND.TotalPar AS 'Course Par',  
    ND.USGA_NZCR AS 'Course Rating',  
    ND.SlopeRating AS 'Slope Rating',  
    CONCAT((ND.Dist1 + ND.Dist2 + ND.Dist3 + ND.Dist4 + ND.Dist5 + ND.Dist6 + ND.Dist7 + ND.Dist8 + ND.Dist9 + ND.Dist10 + +ND.Dist11 + ND.Dist12 + ND.Dist13 + ND.Dist14 + ND.Dist15 + ND.Dist16 + ND.Dist17 + ND.Dist18), CASE WHEN ND.DistUnit = 'Y' THEN ' Yards'END) AS 'Course Length',  
    S.NZGA_Handicap AS 'Handicap Index',  
    SES.CourseHandicap AS 'Course Handicap',  
    -- TODO: Get Playing Handicap  
    S.Gross_Act AS 'Gross Score',  
    S.Score AS 'Adjusted Gross Score',  
    -- TODO: Get Stableford Points  
    -- TODO: GET PCC  
    S.Hole1 AS 'Hole Score 1',  
    S.Hole2 AS 'Hole Score 2',  
    S.Hole3 AS 'Hole Score 3',  
    S.Hole4 AS 'Hole Score 4',  
    S.Hole5 AS 'Hole Score 5',  
    S.Hole6 AS 'Hole Score 6',  
    S.Hole7 AS 'Hole Score 7',  
    S.Hole8 AS 'Hole Score 8',  
    S.Hole9 AS 'Hole Score 9',  
    S.Hole10 AS 'Hole Score 10',  
    S.Hole11 AS 'Hole Score 11',  
    S.Hole12 AS 'Hole Score 12',  
    S.Hole13 AS 'Hole Score 13',  
    S.Hole14 AS 'Hole Score 14',  
    S.Hole15 AS 'Hole Score 15',  
    S.Hole16 AS 'Hole Score 16',  
    S.Hole17 AS 'Hole Score 17',  
    S.Hole18 AS 'Hole Score 18',  
    ND.Stroke1 AS 'SI Hole 1',  
    ND.Stroke2 AS 'SI Hole 2',  
    ND.Stroke3 AS 'SI Hole 3',  
    ND.Stroke4 AS 'SI Hole 4',  
    ND.Stroke5 AS 'SI Hole 5',  
    ND.Stroke6 AS 'SI Hole 6',  
    ND.Stroke7 AS 'SI Hole 7',  
    ND.Stroke8 AS 'SI Hole 8',  
    ND.Stroke9 AS 'SI Hole 9',  
    ND.Stroke10 AS 'SI Hole 10',  
    ND.Stroke11 AS 'SI Hole 11',  
    ND.Stroke12 AS 'SI Hole 12',  
    ND.Stroke13 AS 'SI Hole 13',  
    ND.Stroke14 AS 'SI Hole 14',  
    ND.Stroke15 AS 'SI Hole 15',  
    ND.Stroke16 AS 'SI Hole 16',  
    ND.Stroke17 AS 'SI Hole 17',  
    ND.Stroke18 AS 'SI Hole 18',  
    ND.Par1 AS 'Hole Par 1',  
    ND.Par2 AS 'Hole Par 2',  
    ND.Par3 AS 'Hole Par 3',  
    ND.Par4 AS 'Hole Par 4',  
    ND.Par5 AS 'Hole Par 5',  
    ND.Par6 AS 'Hole Par 6',  
    ND.Par7 AS 'Hole Par 7',  
    ND.Par8 AS 'Hole Par 8',  
    ND.Par9 AS 'Hole Par 9',  
    ND.Par10 AS 'Hole Par 10',  
    ND.Par11 AS 'Hole Par 11',  
    ND.Par12 AS 'Hole Par 12',  
    ND.Par13 AS 'Hole Par 13',  
    ND.Par14 AS 'Hole Par 14',  
    ND.Par15 AS 'Hole Par 15',  
    ND.Par16 AS 'Hole Par 16',  
    ND.Par17 AS 'Hole Par 17',  
    ND.Par18 AS 'Hole Par 18',  
    CASE WHEN ND.Dist1 IS NOT NULL THEN CONCAT(ND.Dist1, CASE WHEN ND.DistUnit = 'Y' THEN ' Yards'END) ELSE 'N/A' END AS 'Hole 1 Length',  
    CASE WHEN ND.Dist2 IS NOT NULL THEN CONCAT(ND.Dist2, CASE WHEN ND.DistUnit = 'Y' THEN ' Yards'END) ELSE 'N/A' END AS 'Hole 2 Length',  
    CASE WHEN ND.Dist3 IS NOT NULL THEN CONCAT(ND.Dist3, CASE WHEN ND.DistUnit = 'Y' THEN ' Yards'END) ELSE 'N/A' END AS 'Hole 3 Length',  
    CASE WHEN ND.Dist4 IS NOT NULL THEN CONCAT(ND.Dist4, CASE WHEN ND.DistUnit = 'Y' THEN ' Yards'END) ELSE 'N/A' END AS 'Hole 4 Length',  
    CASE WHEN ND.Dist5 IS NOT NULL THEN CONCAT(ND.Dist5, CASE WHEN ND.DistUnit = 'Y' THEN ' Yards'END) ELSE 'N/A' END AS 'Hole 5 Length',  
    CASE WHEN ND.Dist6 IS NOT NULL THEN CONCAT(ND.Dist6, CASE WHEN ND.DistUnit = 'Y' THEN ' Yards'END) ELSE 'N/A' END AS 'Hole 6 Length',  
    CASE WHEN ND.Dist7 IS NOT NULL THEN CONCAT(ND.Dist7, CASE WHEN ND.DistUnit = 'Y' THEN ' Yards'END) ELSE 'N/A' END AS 'Hole 7 Length',  
    CASE WHEN ND.Dist8 IS NOT NULL THEN CONCAT(ND.Dist8, CASE WHEN ND.DistUnit = 'Y' THEN ' Yards'END) ELSE 'N/A' END AS 'Hole 8 Length',  
    CASE WHEN ND.Dist9 IS NOT NULL THEN CONCAT(ND.Dist9, CASE WHEN ND.DistUnit = 'Y' THEN ' Yards'END) ELSE 'N/A' END AS 'Hole 9 Length',  
    CASE WHEN ND.Dist10 IS NOT NULL THEN CONCAT(ND.Dist10, CASE WHEN ND.DistUnit = 'Y' THEN ' Yards'END) ELSE 'N/A' END AS 'Hole 10 Length',  
    CASE WHEN ND.Dist11 IS NOT NULL THEN CONCAT(ND.Dist11, CASE WHEN ND.DistUnit = 'Y' THEN ' Yards'END) ELSE 'N/A' END AS 'Hole 11 Length',  
    CASE WHEN ND.Dist12 IS NOT NULL THEN CONCAT(ND.Dist12, CASE WHEN ND.DistUnit = 'Y' THEN ' Yards'END) ELSE 'N/A' END AS 'Hole 12 Length',  
    CASE WHEN ND.Dist13 IS NOT NULL THEN CONCAT(ND.Dist13, CASE WHEN ND.DistUnit = 'Y' THEN ' Yards'END) ELSE 'N/A' END AS 'Hole 13 Length',  
    CASE WHEN ND.Dist14 IS NOT NULL THEN CONCAT(ND.Dist14, CASE WHEN ND.DistUnit = 'Y' THEN ' Yards'END) ELSE 'N/A' END AS 'Hole 14 Length',  
    CASE WHEN ND.Dist15 IS NOT NULL THEN CONCAT(ND.Dist15, CASE WHEN ND.DistUnit = 'Y' THEN ' Yards'END) ELSE 'N/A' END AS 'Hole 15 Length',  
    CASE WHEN ND.Dist16 IS NOT NULL THEN CONCAT(ND.Dist16, CASE WHEN ND.DistUnit = 'Y' THEN ' Yards'END) ELSE 'N/A' END AS 'Hole 16 Length',  
    CASE WHEN ND.Dist17 IS NOT NULL THEN CONCAT(ND.Dist17, CASE WHEN ND.DistUnit = 'Y' THEN ' Yards'END) ELSE 'N/A' END AS 'Hole 17 Length',  
    CASE WHEN ND.Dist18 IS NOT NULL THEN CONCAT(ND.Dist18, CASE WHEN ND.DistUnit = 'Y' THEN ' Yards'END) ELSE 'N/A' END AS 'Hole 18 Length'  
FROM Score S  
         LEFT JOIN Member M ON S.MemberID = M.MemberId  
         LEFT JOIN CMember CM ON M.MemberId = CM.MemberId AND M.Clubno = CM.ClubId  
         LEFT JOIN NZCRData ND ON S.NZCRDataId = ND.NZCRDataID  
         LEFT JOIN Course C ON ND.CourseID = C.CourseID  
         LEFT JOIN ScoreIntent SI ON S.ScoreID = SI.ScoreId  
         LEFT JOIN ScoreEntryStage SES ON SI.ScoreEntryStageId = SES.ScoreEntryStageId  
WHERE S.PlayDate BETWEEN @FromDate AND @ToDate AND S.DeletedDate IS NULL  
  AND M.MemberId = 5089861
```

