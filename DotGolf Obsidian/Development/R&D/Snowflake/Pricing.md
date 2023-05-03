## Questions
- [ ] How often are we importing the data? (Daily/Weekly) **Daily** (changes only)
- [ ] How many people are going to have access to this at union level? 5 members (1 hour * 5)



$2.70  Per Credit 


## Data Loading Requirements

| Parameter                                         | Customer Requirements | Proposed Setup                                                                               |
| ------------------------------------------------- | --------------------- | -------------------------------------------------------------------------------------------- |
| Daily Load Frequency                              | Daily                 | Small Standard Virtual Warehouse (2 Credits per hour) _X-Small is ok for a few million rows_ |
| Loading Window                                    | 1 hour (Worst Case)   | 2 credits * 1 hour per day * 255 _(255 working days in 2022)_                                |
| Credits Required Per Year (Standard On Demand)    | 510                   | $1,377 _Pricing Credit at $2.70 USD P/H_                                                     |
| Credits Required Per Month (Standard On Demand)   | 42.5                  | $114.75 _Pricing Credit at $2.70 USD P/H_                                                    |
| Credits Required Per Year (Enterprise On Demand)  | 510                   | $2,040 _Pricing Credit at $4.00 USD P/H_                                                     | 
| Credits Required Per Month (Enterprise On Demand) | 42.5                  | $170 _Pricing Credit at $4.00 USD P/H_                                                       |


## User Requirements

| Parameter                                         | Customer Requirements | Proposed Setup                                                  |
| ------------------------------------------------- | --------------------- | --------------------------------------------------------------- |
| No. of Users                                      | 2 Users -  (Extreme)  | X-Small Virtual Warehouse (1 Credit Per Hour)                   |
| Workload                                          | 3 Hours Per Day       | ^                                                               |
| Credits Required Per Year (Standard On Demand)    | 765                   | $2,065.5 - (1 Credit @_$2.70_ X 3 Hours P/D X 255 Working Days) |
| Credits Required Per Month (Standard On Demand)   | 63.75                 | $172.125 - (1 Credit @_$2.70_ X 3 Hours P/D X 255 Working Days) |
| Credits Required Per Year (Enterprise On Demand)  | 765                   | $3,060 - (1 Credit @_$4.00_ X 3 Hours P/D X 255 Working Days)   |
| Credits Required Per Month (Enterprise On Demand) | 63.75                 | $255 - (1 Credit @_$4.00_ X 3 Hours P/D X 255 Working Days)     |
| Credits Required Per Month                        | 63.75                 |                                                                 |


| Tier    | Standard | Enterprise |
| ------- | -------- | ---------- |
| Annual  | $3,442.5 | $5,100     |
| Monthly | $286.88  | $425       |

## Storage Requirements
Won't cost us a penny, as we'll be storing it in S3

