#RandA #query 

```sql
set transaction isolation level read uncommitted  
select   
cm.Membercode [Member Number],   
    cm.MemberId [Member Id],  
    isnull(homeclub.Name, c.name) [Home club],   
    cast(s.playdate as date) [Date played],  
    co.name [Course played],   
    n.USGA_NZCR [Course Rating],   
    n.SlopeRating [Slope Rating],   
    s.Score [Adj Gross Score],   
    s.HD [Score Diff],   
    s.NZGA_Handicap [HI on the day],   
    n.NineHole,  
    case when s.played1=0 then -2 when n.par1 != 0 then s.hole1 else null end [hole1],  
    case when s.played2=0 then -2 when n.par2 != 0 then s.hole2 else null end [hole2],  
    case when s.played3=0 then -2 when n.par3 != 0 then s.hole3 else null end [hole3],  
    case when s.played4=0 then -2 when n.par4 != 0 then s.hole4 else null end [hole4],  
    case when s.played5=0 then -2 when n.par5 != 0 then s.hole5 else null end [hole5],  
    case when s.played6=0 then -2 when n.par6 != 0 then s.hole6 else null end [hole6],  
    case when s.played7=0 then -2 when n.par7 != 0 then s.hole7 else null end [hole7],  
    case when s.played8=0 then -2 when n.par8 != 0 then s.hole8 else null end [hole8],  
    case when s.played9=0 then -2 when n.par9 != 0 then s.hole9 else null end [hole9],  
    case when s.played10=0 then -2 when n.par10 != 0 then s.hole10 else null end [hole10],  
    case when s.played11=0 then -2 when n.par11 != 0 then s.hole11 else null end [hole11],  
    case when s.played12=0 then -2 when n.par12 != 0 then s.hole12 else null end [hole12],  
    case when s.played13=0 then -2 when n.par13 != 0 then s.hole13 else null end [hole13],  
    case when s.played14=0 then -2 when n.par14 != 0 then s.hole14 else null end [hole14],  
    case when s.played15=0 then -2 when n.par15 != 0 then s.hole15 else null end [hole15],  
    case when s.played16=0 then -2 when n.par16 != 0 then s.hole16 else null end [hole16],  
    case when s.played17=0 then -2 when n.par17 != 0 then s.hole17 else null end [hole17],  
    case when s.played18=0 then -2 when n.par18 != 0 then s.hole18 else null end [hole18]  
from cmember cm  
    join club c on c.clubid=cm.clubid  
    join member m on m.memberid=cm.memberid   
left join club homeclub on homeclub.clubid=m.clubno  
    join score s on s.memberid = cm.memberid and s.DeletedDate is null  
    join course co on co.courseid=s.courseid  
    join nzcrdata n on n.nzcrdataid=s.nzcrdataid  
where cm.date_resigned is null and s.PlayDate between '2021-09-01' and '2022-08-31'  
  and c.clubid in (  
                   100041, --Ampfield (club id 100041)  
                   100057, --Ashbury (100057) - Willows course only (course id 2528)  
                   100280, --Broughton Heath (100280)  
                   100348,--Castlefields (100348)  
                   102168,--Merley Park (102168)  
                   101338,--Radnor (101338)  
                   101602,--St Pierre Park (101602)  
                   102095--Southport Golf Academy (102095)  
                   )  
order by 1, 3
```
