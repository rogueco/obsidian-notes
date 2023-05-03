```sql
select a.Region,  
       sum(case when a.Gender='M' then a.Amount end) [Men],  
       sum(case when a.Gender='W' then a.Amount end) [Female],  
       sum(case when a.Gender='M' AND a.NZGACategoryID IN (9) then a.Amount end) [Junior Male],  
       sum(case when a.Gender='W' AND a.NZGACategoryID IN (9) then a.Amount end) [Junior Female],  
       sum(a.Amount) [TOTAL]  
from (  
   SELECT r.Region,  
      m.Gender,  
      cm.NZGACategoryID,  
      count(1) Amount  
   from Member m  
      join cMember cm ON cm.MemberId = m.MemberId AND CM.NZGACategoryID NOT IN (6,11,14)  
      join Club c ON cm.ClubId = c.ClubId  
      join Region r on r.RegionId=c.RegionId  
   WHERE cm.Date_Resigned IS NULL  
   GROUP BY r.Region, m.Gender, cm.NZGACategoryID  
) a  
group by a.Region  
order by a.Region
```