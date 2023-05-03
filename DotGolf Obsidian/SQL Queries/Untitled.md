
#bug #freshDesk 


## Bug Summary:
When running the handicaps by gender report, if I'm logged in as a County I shouldn't be able to see the following columns:
- Phone NO.
- Mobile NO.
- Email.

## Steps to Reproduce:
- Login using (county credentials) in England Golf
- Click Reports Tab
- Select and run "Player Handicaps by Gender/Age" report

## Expected:
AS a County, 
WHEN running this report
I WANT to see all columns excluding the ones above.

AS a CLUB
WHEN running this report
I WANT to see the new columns added

AS a UNION,
WHEN Running this report
I WANT to be able to see all of the new columns added

## Actual:
AS any user
WHEN running this report
I CAN see new columns

## Acceptance Criteria:
- [ ] Remove Columns for County Logins
- [ ] Columns remain visible for Club and unions


## Screenshots:


#### Freshdesk Link: 

#### Specific Details: 
_Repo_:
_Controller_:
_Action Name_:
_Request Type_: GET/PUT/PATCH/POST/DELETE
_URL Request_: 


