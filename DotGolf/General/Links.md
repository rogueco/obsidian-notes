
[Standup](https://zoom.us/j/446724995?pwd=eWJhUnNZSFZhdkxiK2hXSGloREF6Zz09)

[DP - Link](https://us02web.zoom.us/j/5132713615?pwd=VzRjVGduUUpFcHRtNTBEWTJkR1dCQT09)
VzRjVGduUUpFcHRtNTBEWTJkR1dCQT09





org -> under settings -> Affiliation Feeds -> under users -> Clickable -> Within that page -> - ability to set up Levy Day years 
	When you select that year, It'll show you the prices
- ability to create new levy year
- Lock dates past the Levy Date 
	- e.g. after we're past this date, members can't update the prices
- Add Membership Cards
- Able to set IsFlexiclubRebate if NZA to true


select * from NZGALevydate l  
left join nzgalevyprice p on l.NZGALevyDateID = p.NZGALevyDateID  
where l.StartDate < l.EndDate




![[Pasted image 20230110204156.png]]


![[Pasted image 20230110203642.png]]

![[Pasted image 20230110203446.png]]
![[Pasted image 20230110203137.png]]


![[Pasted image 20230110203221.png]]