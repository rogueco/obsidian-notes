
## Northern Ireland 
| Category                       | Total   |
| ------------------------------ | ------- |
| Total Members                  | 46,240  |
| *Male* Members                 | 38,401  |
| *Female* Members               | 7,839   |
| *Get Into Golf* Members        | 638     |
| *Get Into Golf Male* Members   | 42      |
| *Get Into Golf Female* Members | 596     |
| Total (Junior Under 18)        | 5,548   |
| Boys (Junior Under 18)         | 4,580   |
| Girls(Junior Under 18)         | 968     |
| **TOTAL**                      | 104,852 |

## Ulster
| Category                       | Total   |
| ------------------------------ | ------- |
| Total Members                  | 59,487  |
| *Male* Members                 | 49,360  |
| *Female* Members               | 10,127  |
| *Get Into Golf* Members        | 849     |
| *Get Into Golf Male* Members   | 140     |
| *Get Into Golf Female* Members | 709     |
| Total (Junior Under 18)        | 6,669   |
| Boys (Junior Under 18)         | 5,519   |
| Girls(Junior Under 18)         | 1,150   |
| **TOTAL**                      | 134,010 |


```sql
-- GET Categories to exclude  
SELECT * FROM NZGACategory C  
-- Categories to exclude 11,6,8  
  
-- GET Regions for NI  
-- Northern Ireland are: Antrim, Armagh, Down, Fermanagh, Derry and Tyrone.  
-- Counties in Ulster are: Antrim, Armagh, Down, Fermanagh, Derry and Tyrone, Cavan, Donegal and Monaghan  
SELECT * FROM Region  
-- 1, 2, 7, 9, 11, 28  
-- Counties in Ulster are: Antrim, Armagh, Down, Fermanagh, Derry and Tyrone, Cavan, Donegal and Monaghan  
-- 1, 2, 4, 7, 8, 9, 11, 23, 28  
  
-- Northern Ireland Members  
-- Northern Ireland are: Antrim, Armagh, Down, Fermanagh, Derry and Tyrone.  
-- 1, 2, 7, 9, 11, 28  
SELECT  
    SUM(CASE WHEN CM.NZGACategoryID NOT IN (11,6,8) THEN 1 ELSE 0 END) 'TOTAL MEMBERS',  
    SUM(CASE WHEN CM.NZGACategoryID NOT IN (11,6,8) AND M.Gender = 'M' THEN 1 ELSE 0 END) 'TOTAL MALE MEMBERS',  
    SUM(CASE WHEN CM.NZGACategoryID NOT IN (11,6,8) AND M.Gender = 'W' THEN 1 ELSE 0 END) 'TOTAL FEMALE MEMBERS',  
    SUM(CASE WHEN CM.NZGACategoryID IN (16) THEN 1 ELSE 0 END) 'TOTAL GET INTO GOLF MEMBERS',  
    SUM(CASE WHEN CM.NZGACategoryID IN (16) AND M.Gender = 'M' THEN 1 ELSE 0 END) 'TOTAL GET INTO MALE GOLF MEMBERS',  
    SUM(CASE WHEN CM.NZGACategoryID IN (16) AND M.Gender = 'W' THEN 1 ELSE 0 END) 'TOTAL GET INTO FEMALE GOLF MEMBERS',  
    SUM(CASE WHEN CM.NZGACategoryID IN (9) THEN 1 ELSE 0 END) 'TOTAL JUNIOR MEMBERS',  
    SUM(CASE WHEN CM.NZGACategoryID IN (9) AND M.Gender = 'M' THEN 1 ELSE 0 END) 'TOTAL JUNIOR MALE MEMBERS',  
    SUM(CASE WHEN CM.NZGACategoryID IN (9) AND M.Gender = 'W' THEN 1 ELSE 0 END) 'TOTAL JUNIOR FEMALE MEMBERS'  
FROM Cmember CM  
         JOIN Club C on CM.ClubId = C.ClubID AND C.Regionid IN (1,2,7,9,11,28)  
         JOIN Member M ON CM.MemberId = M.MemberId  
WHERE  
    CM.DeletedDate IS NULL  
  AND ISNULL(CM.Date_Started, '1900-01-01') < CONVERT(datetime, '2023-01-01')  
  AND ISNULL(CM.Date_Resigned, '2022-12-30')  
    BETWEEN CONVERT(datetime, '2022-05-01') AND CONVERT(datetime, '2022-12-31')  
  
-- Ulster Members  
-- Counties in Ulster are: Antrim, Armagh, Down, Fermanagh, Derry and Tyrone, Cavan, Donegal and Monaghan  
-- 1, 2, 4, 7, 8, 9, 11, 23, 28  
SELECT  
    SUM(CASE WHEN CM.NZGACategoryID NOT IN (11,6,8) THEN 1 ELSE 0 END) 'TOTAL MEMBERS',  
    SUM(CASE WHEN CM.NZGACategoryID NOT IN (11,6,8) AND M.Gender = 'M' THEN 1 ELSE 0 END) 'TOTAL MALE MEMBERS',  
    SUM(CASE WHEN CM.NZGACategoryID NOT IN (11,6,8) AND M.Gender = 'W' THEN 1 ELSE 0 END) 'TOTAL FEMALE MEMBERS',  
    SUM(CASE WHEN CM.NZGACategoryID IN (16) THEN 1 ELSE 0 END) 'TOTAL GET INTO GOLF MEMBERS',  
    SUM(CASE WHEN CM.NZGACategoryID IN (16) AND M.Gender = 'M' THEN 1 ELSE 0 END) 'TOTAL GET INTO MALE GOLF MEMBERS',  
    SUM(CASE WHEN CM.NZGACategoryID IN (16) AND M.Gender = 'W' THEN 1 ELSE 0 END) 'TOTAL GET INTO FEMALE GOLF MEMBERS',  
    SUM(CASE WHEN CM.NZGACategoryID IN (9) THEN 1 ELSE 0 END) 'TOTAL JUNIOR MEMBERS',  
    SUM(CASE WHEN CM.NZGACategoryID IN (9) AND M.Gender = 'M' THEN 1 ELSE 0 END) 'TOTAL JUNIOR MALE MEMBERS',  
    SUM(CASE WHEN CM.NZGACategoryID IN (9) AND M.Gender = 'W' THEN 1 ELSE 0 END) 'TOTAL JUNIOR FEMALE MEMBERS'  
FROM Cmember CM  
     JOIN Club C on CM.ClubId = C.ClubID AND C.Regionid IN (1,2,4,7,8,9,11,23,28)  
     JOIN Member M ON CM.MemberId = M.MemberId  
WHERE  
    CM.DeletedDate IS NULL  
  AND ISNULL(CM.Date_Started, '1900-01-01') < CONVERT(datetime, '2023-01-01')  
  AND ISNULL(CM.Date_Resigned, '2022-12-30')  
    BETWEEN CONVERT(datetime, '2022-05-01') AND CONVERT(datetime, '2022-12-31')
```