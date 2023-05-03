#englandGolf #iGolf

 
 This query is ran monthly for [[England Golf Contacts#Claire Hodgson]]


```sql

SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
DECLARE @ClubId INT = 910053;
DECLARE @DateIndependentGolferStarted DATETIME = '2021-07-13'
DECLARE @DateRangeStart DATETIME = '2021-07-13';
DECLARE @DateRangeFrom DATETIME = '2022-08-31';
DECLARE @VoucherCode VARCHAR(50);

SELECT
    M.FirstName,
    M.LastName,
    CONVERT(VARCHAR, M.DOB, 103) [DOB],
    M.Gender,
    M.MemberId,
    M.CentralMemberCode [Membership Number],
    CMemberActiveIndependentGolf.Email [Email Address],
    M.NZGA_Handicap [Handicap Index],
    (SELECT COUNT(*)
     FROM [Score] S
     WHERE M.MemberId = S.MemberID
       AND S.DeletedDate IS NULL
       AND S.PlayDate
           BETWEEN CMemberActiveIndependentGolf.Date_Started
           AND ISNULL(CMemberActiveIndependentGolf.Date_Resigned, GETDATE())) [Submitted Score Whilst iGolf Member],
    CONVERT(VARCHAR, CMemberActiveIndependentGolf.Date_Started, 103) [Date Started with iGolf],
    (CASE WHEN MA.VoucherCodeApplied != '' THEN TRIM(UPPER(MA.VoucherCodeApplied)) END)[Voucher],
    FirstInvoice.CreateDate [Date of first Paid Subscription],
    (CASE WHEN CMemberActiveIndependentGolf.AutoResignAtEndOfSubscription = 1 AND CMemberActiveIndependentGolf.Date_Resigned IS NOT NULL THEN 'Yes' ELSE 'No' END) [Cancellation With intevention (New Club/EG Resign)],
    (CASE WHEN CMemberActiveIndependentGolf.AutoResignAtEndOfSubscription = 1 AND CMemberActiveIndependentGolf.Date_Resigned IS NULL THEN 'Yes' ELSE 'No' END) [Future Cancellation],
    (CASE WHEN CMemberActiveIndependentGolf.AutoResignAtEndOfSubscription = 1 AND CMemberActiveIndependentGolf.Date_Resigned IS NULL THEN CONVERT(VARCHAR,CMemberActiceItem.EndDate, 103) END) [Future Cancellation Membership end date],
    (CASE WHEN CMemberActiveIndependentGolf.ResignMethod LIKE 'AUTORESIGN%' THEN CMemberActiveIndependentGolf.Date_Resigned END) [Date of auto resignations (Member Cancellation/Payment Failure)],
    (CASE
        WHEN (CMemberActiveIndependentGolf.ResignMethod LIKE 'AUTORESIGN%' AND DATEDIFF(day, CONVERT(VARCHAR, CMemberActiveIndependentGolf.Date_Started, 111), CONVERT(VARCHAR, CMemberActiveIndependentGolf.Date_Resigned, 111)) IN (29,30,41,44,53,364)) THEN 'Member Cancelled'
        WHEN (CMemberActiveIndependentGolf.ResignMethod LIKE 'AUTORESIGN%' AND DATEDIFF(day, CONVERT(VARCHAR, CMemberActiveIndependentGolf.Date_Started, 111), CONVERT(VARCHAR, CMemberActiveIndependentGolf.Date_Resigned, 111)) IN (31,34,37,41,365,366,368,369,372,373,375,376,377,378,379,380,382)) THEN 'Payment Failed' END) [Auto resignation type],
    I.PaidDate [Most recent transaction],
    CONVERT(VARCHAR, CMemberActiveIndependentGolf.Date_Resigned, 103) [Date Resigned from iGolf],
    CONVERT(VARCHAR, tr.DPSCompleteAttempted, 103) [Date iGolf Membership Refunded],
    CONVERT(VARCHAR, CMemberAfterIndependentGolf.Date_Started, 103) [Date Started at New Club],
    C.Name [New Club],
    R.Region [County],
    CONVERT(VARCHAR, CMemberAfterIndependentGolf.Date_Resigned, 103) [Date Resigned from New Club],
    PreviousClub.Name [Previous Club],
    CONVERT(VARCHAR,CMemberBeforeIndependentGolf.Date_Resigned, 103) [Date Resigned From Club],
 case
        when Cat.MembershipDurationMonths<12 then 'Month ' + cast(datediff(mm,CMemberActiveIndependentGolf.Date_Started,coalesce(CMemberActiveIndependentGolf.Date_Resigned,getdate())) as varchar(10))
		    else 'Year ' +
			    cast((datediff(year, CMemberActiveIndependentGolf.Date_Started, coalesce(CMemberActiveIndependentGolf.Date_Resigned,getdate()))
						- case when datepart(dayofyear, coalesce(CMemberActiveIndependentGolf.Date_Resigned,getdate())) < datepart(dayofyear, CMemberActiveIndependentGolf.Date_Started) then 1 else 0 end
					) + 1 as varchar(10))
			end [Membership Year/Month]
FROM CMember CMemberActiveIndependentGolf
    LEFT JOIN Category Cat on CMemberActiveIndependentGolf.CategoryID = Cat.CategoryID
    LEFT JOIN CMemberItem CMemberActiceItem ON  CMemberActiceItem.CMemberItemId = (SELECT TOP 1 CMI.CMemberItemId
                                                                                   FROM CMemberItem CMI
                                                                                   WHERE CMI.MemberId = CMemberActiveIndependentGolf.MemberId
                                                                                     AND CMI.ClubId = @ClubId ORDER BY CMI.EndDate DESC)
    LEFT JOIN CMember CMemberAfterIndependentGolf on CMemberAfterIndependentGolf.CMemberUID =
                                                     (SELECT TOP 1 CM.CMemberUID
                                                      FROM CMember CM
                                                      WHERE CM.MemberId = CMemberActiveIndependentGolf.MemberId
                                                        AND(CM.Date_Started > @DateIndependentGolferStarted)
                                                        AND CM.Date_Started > CMemberActiveIndependentGolf.Date_Started
                                                        AND (CM.Date_Started = (SELECT MAX(CmAll.Date_Started) FROM CMember CmALL WHERE CmALL.MemberId = CM.MemberId AND CmALL.ClubId = CM.ClubId) OR CM.Date_Resigned IS NULL)
                                                        AND CM.ClubId != @ClubId
                                                        AND CM.DeletedDate IS NULL
                                                        AND CM.IsMRU = 1 ORDER BY CM.Date_Started)
    LEFT JOIN Club C ON CMemberAfterIndependentGolf.ClubId = C.ClubID
    LEFT JOIN Region R on C.RegionId = R.RegionId
    LEFT JOIN Member M ON CMemberActiveIndependentGolf.MemberId = M.MemberId
    LEFT JOIN CMember CMemberBeforeIndependentGolf ON CMemberBeforeIndependentGolf.MemberId = M.MemberId
                                                     AND CMemberBeforeIndependentGolf.ClubId != @ClubId
                                                     AND CMemberBeforeIndependentGolf.DeletedDate IS NULL
                                                     AND (CMemberBeforeIndependentGolf.Date_Resigned = (SELECT MAX(CmAll.Date_Resigned) FROM CMember CmALL WHERE CmALL.MemberId = CMemberAfterIndependentGolf.MemberId)
                                                         OR CMemberBeforeIndependentGolf.Date_Resigned is null
                                                     AND ISNULL(CMemberBeforeIndependentGolf.Date_Started, '2021-07-12') < CMemberActiveIndependentGolf.Date_Started)
                                                     AND CMemberBeforeIndependentGolf.IsMRU = 1
    LEFT JOIN Club PreviousClub on CMemberBeforeIndependentGolf.ClubId = PreviousClub.ClubID
    LEFT JOIN CWMembershipApplication MA ON MA.memberid = CMemberActiveIndependentGolf.MemberId
                                                AND (@VoucherCode IS NULL OR MA.VoucherCodeApplied = @VoucherCode)
    LEFT JOIN TBTransaction TT ON TT.MembershipApplicationId=MA.MembershipApplicationId
                                      AND TT.DPSCompleted = 1
    LEFT JOIN TBTransactionRefund TR ON TR.TBTransactionId = TT.Id
                                            AND TR.DPSCompleteMessage LIKE 'Approved%'
    LEFT JOIN Invoice FirstInvoice ON FirstInvoice.InvoiceId = (SELECT TOP 1 I1.InvoiceId FROM Invoice I1 WHERE I1.MemberId = M.MemberId AND I1.PaidDate IS NOT NULL AND I1.Amount > 0 ORDER BY I1.PaidDate)
    LEFT JOIN Invoice I ON I.InvoiceId = (SELECT TOP 1 I2.InvoiceId FROM Invoice I2 WHERE I2.MemberId = M.MemberId AND I2.PaidDate IS NOT NULL ORDER BY I2.PaidDate DESC)
WHERE CMemberActiveIndependentGolf.ClubId = @ClubId
  AND CMemberActiveIndependentGolf.DeletedDate IS NULL
  AND CMemberActiveIndependentGolf.IsMRU = 1
  AND CMemberActiveIndependentGolf.Date_Started BETWEEN @DateRangeStart AND @DateRangeFrom
ORDER BY CMemberActiveIndependentGolf.Date_Started, CMemberActiveIndependentGolf.Surname,CMemberActiveIndependentGolf.FirstName


```