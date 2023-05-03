#englandGolf #iGolf

 
 This query is ran monthly for [[England Golf Contacts#Claire Hodgson]]


```sql

DECLARE @gender VARCHAR(1) = 'B';  
DECLARE @ClubId INT = 910053;  
DECLARE @HandicapFrom DECIMAL(4,1);  
DECLARE @HandicapTo DECIMAL(4,1);  
DECLARE @FromDate DATE = '2022-11-01'  
DECLARE @ToDate DATE = '2022-11-30'  
DECLARE @includecompetitionscores bit = 0  
  
SELECT m.MemberId  
into #tt  
from Member m  
join cmember cm on cm.memberid=m.memberid and cm.Clubid = @ClubId and cm.date_resigned is null  
where (  
        @gender = 'B'  
        or @gender = m.gender  
    )  
   and (m.nzga_handicap >= @HandicapFrom or @HandicapFrom is null or m.nzga_handicap is null)  
    and (m.nzga_handicap <= @HandicapTo or @HandicapTo is null)  
    and exists(select 1 from score s where s.PlayDate >= @FromDate and s.PlayDate <= @ToDate and s.deleteddate is null and s.MemberId=m.memberId)  
  
declare @MemberCount int = (select count(1) from #tt)  
  
SELECT s.PlayDate,  
    S.PlayDateTime [Scorecard Download],  
    ME.CreateDate [Score Submitted],  
    S.CaptureDate [Score Attested Or Entered By ISV],  
    m.MemberId,  
    m.CentralMemberCode [Member No.],  
    ISNULL(m.Name, m.LastName+', '+m.FirstName) [Name], t1.Email,  
    co.Name [Course],n.Marker, s.Score,  
    (case when s.IsCompetitionScore = 1 then 'Yes' else 'No' end) [Competition Score],  
    iif(s.EnteredVia='A','Yes','No') [IsApp],  
    coalesce(am.Name, s.AttesterInfo) [Attester],  
    s.ScoreID,  
   case when @MemberCount=2500 and s.ScoreID = FIRST_VALUE(s.ScoreID) OVER (ORDER BY s.ScoreID desc) then 'More than 2500 members were found.  Please narrow down your handicap filters.' end [Warning]  
from Score s  
join #tt t on t.MemberId=s.MemberID  
join member m on m.MemberId=t.MemberID  
join NZCRData n on n.NZCRDataId=s.NZCRDataId  
join Course co on co.CourseId=n.CourseId  
left join Scorecard SC on S.ScoreID = SC.ScoreID  
left join Message ME on ME.MessageId =  
    (  
        select top 1 M2.MessageId  
        from Message M2  
        where SC.Id = M2.LinkValue  
        and S.AttesterPassportId = M2.RecipientPassportId  
        and M2.LinkType = 'VERIFYSCOREREQUEST'  
        order by M2.CreateDate  
    )  
left join Passport p on p.PassportId=s.AttesterPassportId  
left join Member am on am.MemberId=p.MemberId  
outer apply (  
    select top 1 Email  
    from Cmember cm  
    where cm.MemberId=m.MemberId and cm.ClubId=@ClubId and cm.date_resigned is null and isnull(cm.email,'') != ''  
    order by Date_Started desc  
) t1  
where s.PlayDate between @FromDate and @ToDate  
  and s.IsPenaltyScore = 0  
  and s.DeletedDate is null  
  and (  
        (@includecompetitionscores=1) -- Show All  
        OR (@includecompetitionscores=0 AND isnull(s.IsCompetitionScore,0) = 0) -- Competition scores  
    )  
order by s.ScoreId desc  
option (recompile)  
  
-- We need to drop temp table after  
BEGIN TRANSACTION  
DROP TABLE #tt  
ROLLBACK TRANSACTION

```