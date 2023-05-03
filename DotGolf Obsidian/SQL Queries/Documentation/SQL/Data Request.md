

```sql
 DECLARE @MemberId int = 3961592  
DECLARE @PassportId int = 381296  
-- IGNORE  
SELECT * FROM CMemberHistory X WHERE X.MemberId = @MemberId -- Ignore  
SELECT * FROM CWMemberPrivacy X WHERE X.MemberId = @MemberId  
SELECT * FROM CWMemberUpdateLog X WHERE X.MemberId = @MemberId  
SELECT * FROM MemberHistory X WHERE X.MemberId = @MemberId  
SELECT * FROM NZGALevy X WHERE X.MemberId = @MemberId  
SELECT * FROM Passport X WHERE X.MemberId = @MemberId  
SELECT * FROM ScoreHistory X WHERE X.MemberId = @MemberId  
SELECT * FROM PassportMessageType X WHERE X.PassportId = @PassportId  
SELECT * FROM PassportCredential X WHERE X.PassportID = @PassportId  
SELECT * FROM WebSession X WHERE X.PassportId = @PassportId  
-- MemberId  
DECLARE @MemberId int = 3961592  
DECLARE @PassportId int = 381296  
SELECT CM.CentralMemberCode, CM.FirstName, CM.Surname, CM.Address1, CM.Address2, CM.Address3, CM.Postal_Code, CM.City,CM.Phone_Mobile, CM.Email, CM.HomeClubCno, CM.Date_Resigned, CM.Date_Started, CM.DOB, C.Name AS 'ClubName', CM.IsDeceased FROM Cmember CM JOIN Club C on CM.ClubId = C.ClubID WHERE CM.MemberId = @MemberId -- CMember  
SELECT FR.CreateDate, M.Name, FR.IsRejected, FR.DeletedDate FROM FriendRequest FR JOIN Member M ON FR.FriendID = M.MemberId WHERE FR.MemberId = @MemberId -- FriendRequest  
SELECT C.Name AS 'ClubName', M.Name, M.Gender, M.Date_resigned, M.Last_playdate, M.Changedate, M.FirstName, M.LastName, CASE WHEN M.ProfileImageId IS NOT NULL THEN 'true' END, M.CentralMemberCode, M.IsProfessional, M.WHS_Handicap, M.NeedsHandicapUpdate  FROM member M JOIN Club C ON M.Clubno = C.ClubID WHERE M.MemberId = @MemberId -- Member  
SELECT MF.CreateDate, M.Name FROM MemberFriends MF JOIN Member M ON MF.FriendID = M.MemberId WHERE MF.MemberId = @MemberId -- MemberFriends  
SELECT C.Name, ND.Marker, S.PlayDate, S.Gross_Act, S.Score, S.NZGA_Handicap, S.CaptureDate, C.Name AS 'CapturedByClub', S.CanEdit, S.HD, S.Hole1, S.Hole2, S.Hole3, S.Hole4, S.Hole5, S.Hole6, S.Hole7, S.Hole8, S.Hole9, S.Hole10, S.Hole11, S.Hole12, S.Hole13, S.Hole14, S.Hole15, S.Hole16, S.Hole17, S.Hole18, S.ChangeDate, S.IsMatchPlayScore, S.DeletedDate, S.Played1,  S.Played2,  S.Played3,  S.Played4,  S.Played5,  S.Played6,  S.Played7,  S.Played8,  S.Played9,  S.Played10,  S.Played11,  S.Played12,  S.Played13,  S.Played14,  S.Played15,  S.Played16,  S.Played17,  S.Played18, S.IsHandicapModified, S.IsCompetitionScore, S.IsPenaltyScore, S.PlayTime, S.PlayDateTime, S.EnteredVia, ATTESTER.Name AS 'AttesterInfo'  FROM Score S JOIN Member ATTESTER ON S.AttesterInfo = ATTESTER.CentralMemberCode  JOIN Club CB ON S.CapturedByClub = CB.ClubID JOIN NZCRData ND on S.NZCRDataId = ND.NZCRDataID JOIN Course C ON ND.CourseID = C.CourseID WHERE S.MemberId = @MemberId ORDER BY S.PlayDateTime DESC -- Score  
SELECT C.Name, ND.Marker, SC.DateCreated, SC.DatePlayed, SC.Returned, SC.Deleted, SC.PrintedHandicapIndex, SC.Virtual, SC.IsProfessional, SC.IsSideMatchOn FROM Scorecard SC JOIN Club C ON SC.ClubID = C.ClubID JOIN NZCRData ND on SC.MarkerID = ND.MarkerID WHERE SC.MemberId = @MemberId -- Scorecard  
SELECT SS.IsPrimary, SS.CreateDate, SS.Hole1, SS.Hole2, SS.Hole3, SS.Hole4, SS.Hole5, SS.Hole6, SS.Hole7, SS.Hole8, SS.Hole9, SS.Hole10, SS.Hole11, SS.Hole12, SS.Hole13, SS.Hole14, SS.Hole15, SS.Hole16, SS.Hole17, SS.Hole18, SS.DeletedDate, SS.Name, SS.Gender, SS.HandicapIndex, SS.CourseHandicap, SS.IsGuest, SS.MarkerName FROM ScoreEntryStage SS WHERE SS.ScorecardId IN(SELECT X.Id FROM Scorecard X WHERE X.MemberId = @MemberId) --ScoreEntryStage  
SELECT C.Name AS 'Club', SI.IsCompetitionPlay, SI.PlayedAtUTC, SI.CreateDate, SI.DeletedDate, SI.DeleteReason, SI.ChangeDate, SI.IsApproved, SI.LastReminderSent FROM ScoreIntent SI JOIN Club C ON SI.ClubId = C.ClubId WHERE SI.MemberId = @MemberId -- ScoreIntent  
-- PASSPORT ID  
SELECT MD.DeviceUniqueIdentifier, MD.DeviceType, MD.CreateDate, MD.DeletedDate FROM MobileDevice MD WHERE MD.PassportId = @PassportId -- MobileDevice  
SELECT EST.Name, EU.UnsubscribeDate, EU.DeletedDate FROM EmailUnsubscribed EU JOIN EmailSubscriptionType EST on EU.EmailSubscriptionTypeId = EST.EmailSubscriptionTypeId WHERE EU.PassportId= @PassportId -- EmailUnsubscribed  
SELECT PR.CreateDate, PR.CompletedDate, PR.Username FROM PasswordResetRequest PR WHERE PR.PassportId = @PassportId -- PasswordResetRequest  
SELECT PEV.Email, PEV.CreateDate, PEV.VerifiedDate FROM PassportEmailVerify PEV WHERE PEV.PassportID = @PassportId -- PassportEmailVerify  
SELECT M.CreateDate, M.MessageText, M.DeleteDate, M.Private, M.[Read], M.Deleted, M.LinkType FROM Message M WHERE M.SenderPassportId = @PassportId -- Message  
  
-- Future Reference  
SELECT TOP 10 * FROM RSResult RSR  
SELECT TOP 1 * FROM RSEntry;  
  
SELECT TOP 50 * FROM NZCRData  
  
-- MemberId Empty Table  
SELECT TOP 10 * FROM CMemberItem X WHERE X.MemberId = @MemberId -- Empty  
SELECT TOP 10 * FROM CMemberChangeRequest X WHERE X.MemberId = @MemberId -- Empty  
SELECT TOP 10 * FROM CMemberItemHistory X WHERE X.MemberId = @MemberId -- Empty  
SELECT TOP 10 * FROM CWEmailRecipient X WHERE X.MemberId = @MemberId -- Empty  
SELECT TOP 10 * FROM CWMembershipApplication X WHERE X.MemberId = @MemberId -- Empty  
SELECT * FROM HandicapAdjustment X WHERE X.MemberId = @MemberId -- empty  
SELECT * FROM HomeClubChangeRequest X WHERE X.MemberId = @MemberId -- empty  
SELECT * FROM InterClubMessage X WHERE X.MemberId = @MemberId -- empty  
SELECT * FROM Invoice X WHERE X.MemberId = @MemberId -- empty  
SELECT * FROM MemberLocalHandicap X WHERE X.MemberId = @MemberId -- empty  
SELECT * FROM OOMPlayer X WHERE X.MemberId = @MemberId -- empty  
SELECT * FROM SubAutoRenewalRetry X WHERE X.MemberId = @MemberId -- empty  
SELECT * FROM SubRenewalData X WHERE X.MemberId = @MemberId -- empty  
SELECT * FROM TBClubVisitor X WHERE X.MemberId = @MemberId -- empty  
SELECT * FROM TBMember X WHERE X.MemberId = @MemberId -- empty  
-- PASSPORT ID Empty Table  
SELECT * FROM DebugLogEntry X WHERE X.PassportId = @PassportId -- empty  
SELECT * FROM PassportNote X WHERE X.PassportId = @PassportId -- empty  
SELECT * FROM PassportClubLog X WHERE X.PassportId = @PassportId -- empty  
SELECT * FROM PassportClubTag X WHERE X.PassportId = @PassportId -- empty  
SELECT * FROM BillingToken X WHERE X.PassportId = @PassportId -- empty  
SELECT * FROM CGUser X WHERE X.PassportId = @PassportId -- empty  
SELECT * FROM TBTransaction X WHERE X.MemberId = @MemberId -- empty  
  
-- not available in EG  
SELECT * FROM MembershipApplicationTransaction X WHERE X.MemberId = @MemberId  
SELECT * FROM RawMembershipApplicationTransaction X WHERE X.MemberId = @MemberId  
SELECT * FROM RawSubsTransaction X WHERE X.MemberId = @MemberId  
SELECT * FROM SubsTransaction X WHERE X.MemberId = @MemberId  
  
  
SELECT DISTINCT  
    c.name AS 'ColumnName',  
    t.name AS TableName,  
    SUM(p.rows) AS RowCounts  
FROM  
    sys.tables t  
INNER JOIN  
    sys.indexes i ON t.object_id = i.object_id  
INNER JOIN  
    sys.partitions p ON i.object_id = p.object_id AND i.index_id = p.index_id  
INNER JOIN  
        sys.columns c on c.object_id = t.object_id  
WHERE  
    t.is_ms_shipped = 0  
        AND p.rows > 0  
        AND (c.name like '%MemberId%' OR c.name LIKE '%PassportId%')  
GROUP BY  
    t.name, p.rows, c.name  
ORDER BY  
    TableName;
```