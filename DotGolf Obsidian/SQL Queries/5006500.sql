-- Query 1
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
SELECT
    Gender, Score, PlayDate
FROM Score
WHERE PlayDate
    BETWEEN '2022-05-01'
    AND '2022-05-30'
ORDER BY Gender,
         PlayDate;


-- Query 2
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
SELECT
    s.MemberID, s.EnteredVia, m.Name, cwer.EmailAddress
FROM Score s
JOIN member m ON m.MemberID = s.MemberID
JOIN CWEmailRecipient cwer ON cwer.MemberId = s.MemberId
WHERE s.EnteredVia = 'A'
AND s.DeletedDate IS NULL
GROUP BY s.MemberID, s.EnteredVia, m.Name, cwer.EmailAddress
ORDER BY m.Name;


SELECT * FROM Score WHERE MemberID = 4121355

-- Query 3
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
SELECT
    co.Name,
    COUNT(*)
FROM Score s
JOIN Course c ON c.CourseID = s.CourseID
JOIN Country co ON co.Id = c.CountryId
WHERE s.DeletedDate IS NULL
AND c.Clubid IS NULL
  -- There are a couple of England results that no longer have a ClubID
AND co.Id != 75
GROUP BY c.CountryId, co.Name
ORDER BY co.Name;

