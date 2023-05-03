

**This is a *quick-start* guide to ingegrate Amazon S3 with Snowflake**


### AWS SETUP

#### CREATE IAM Policy
[Snowflake Docs](https://docs.snowflake.com/en/user-guide/data-load-s3-config-storage-integration.html)

1) Create IAM Policy
```json
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
              "s3:PutObject",
              "s3:GetObject",
              "s3:GetObjectVersion",
              "s3:DeleteObject",
              "s3:DeleteObjectVersion"
            ],
            "Resource": "arn:aws:s3:::dg-nz-dev-ingestion/*"
        },
        {
            "Effect": "Allow",
            "Action": [
                "s3:ListBucket",
                "s3:GetBucketLocation"
            ],
            "Resource": [
				"arn:aws:s3:::dg-nz-dev-ingestion/",  
				"arn:aws:s3:::dg-nz-dev-ingestion/snowflake/*"
            ],
            "Condition": {
                "StringLike": {
                    "s3:prefix": [
                        "*"
                    ]
                }
            }
        }
    ]
}
```

2) Create IAM Role 
	1) In the Account ID field, enter your own AWS account ID temporarily. Later, you will modify the trusted relationship and grant access to Snowflake.
	2.  Select the Require external ID option. Enter a dummy ID such as `0000`. Later, you will modify the trusted relationship and specify the external ID for your Snowflake stage. An external ID is required to grant access to your AWS resources (i.e. S3) to a third party (i.e. Snowflake).
	3. Record the Role ARN value located on the role summary page. In the next step, you will create a Snowflake integration that references this role.


## SNOWFLAKE
### CREATE DATABASE
1) Navigate to **DATABASES** from **DATA** from sidepanel 
2) Click Add **Database** & enter a name

![[Pasted image 20221121144405.png]]

If you want to create a schema, you can - however it's just as easy for the time being to use the `public` schema that is available

#### CREATING TABLES

Frustratingly, you need to beforehand define your Table Schema.

1) Click on the defined scheme - I'm going to use `public`
2) On the right hand side, you should now see the 'Create' button. Click this
	1) navigate to table, then click 'Standard' 

You are able to run the below to create the tabel schema
```sql
create TABLE ASSOCIATION (
	OP VARCHAR(16777216),
	DMS_TIMESTAMP TIMESTAMP_LTZ ,
	ASSOCIATIONID NUMBER(38,0),
	PARENTASSOCIATIONID NUMBER(38,0),
	NAME VARCHAR(16777216),
	WEBSITEURL VARCHAR(16777216),
	LOGOIMAGE VARCHAR(16777216),
	TOURNAMENTSREPLYTOEMAILADDRESS VARCHAR(16777216),
	REGIONID NUMBER(38,0),
	ISPROFESSIONAL BOOLEAN,
	EMAILBOUNCETRACKINGENABLED BOOLEAN,
	EMAILSIGNATURE VARCHAR(16777216),
	LIVE_SHOWREPORTFOOTERS BOOLEAN,
	LIVE_HOMEURL VARCHAR(16777216),
	ACCXEROUSERAGENT VARCHAR(16777216),
	ACCXEROCONSUMERKEY VARCHAR(16777216),
	ACCXEROPRIVATEKEY VARCHAR(16777216),
	CONTACTNAME VARCHAR(16777216),
	CONTACTPHONE VARCHAR(16777216),
	FACEBOOKURL VARCHAR(16777216),
	WHSORGANISATIONUID VARCHAR(16777216),
	DELETEDDATE TIMESTAMP_LTZ ,
	CODE VARCHAR(16777216),
	SHORTNAME VARCHAR(16777216),
	ASSOCIATIONUID VARCHAR(16777216),
	CONTACTEMAIL VARCHAR(16777216),
	LATIUDE FLOAT,
	LONGITUDE FLOAT,
	LOC_ADDRESS1 VARCHAR(16777216),
	LOC_ADDRESS2 VARCHAR(16777216),
	LOC_ADDRESS3 VARCHAR(16777216),
	FULLNAME VARCHAR(16777216),
	DEFAULTACCOUNTINGSYSTEMID VARCHAR(16777216),
	VALIDFROMUTC TIMESTAMP_LTZ ,
	VALIDTOUTC TIMESTAMP_LTZ ,
	ROWVERSION VARCHAR(16777216)
);
```

#### CREATE FILE FORMAT

Create a File Format via the use of the Create dropdown CTA
```sql
create file format MY_PARQUET_FORMAT
    type = PARQUET
```


### CREATE STORAGE INTEGRATION
[Snowflake Docs](https://docs.snowflake.com/en/user-guide/data-load-s3-config-storage-integration.html)
A Storage Integration environment is needed to act as the symboytic link between Snowflake & AWS

```sql
CREATE OR REPLACE STORAGE INTEGRATION S3_Integration
  TYPE = EXTERNAL_STAGE
  STORAGE_PROVIDER = 'S3'
  ENABLED = TRUE
  STORAGE_AWS_ROLE_ARN = '<iam_role>'
  STORAGE_ALLOWED_LOCATIONS = ('s3://dg-nz-dev-ingestion/Snowflake/', 's3://dg-nz-dev-ingestion/');
```


We need to give Snowflake permission to access the buckets by adding information to our IAM Role Trust Relationships

```sql
DESC INTEGRATION S3_Integration;
```

| Property | Property_type | property_value | property_default | 
| -------- | ------------- | -------------- | ---------------- |
| ENABLED  | Boolean       | true           |         False         |
| STORAGE_ALLOWED_LOCATIONS | List          | s3://mybucket1/mypath1/,s3://mybucket2/mypath2/                                | []               |
| STORAGE_BLOCKED_LOCATIONS | List          | s3://mybucket1/mypath1/sensitivedata/,s3://mybucket2/mypath2/sensitivedata/    | []               |
| STORAGE_AWS_IAM_USER_ARN  | String        | arn:aws:iam::123456789001:user/abc1-b-self1234                                 |                  |
| STORAGE_AWS_ROLE_ARN      | String        | arn:aws:iam::001234567890:role/myrole                                          |                  |
| STORAGE_AWS_EXTERNAL_ID   | String        | MYACCOUNT_SFCRole=2_a123456/s0aBCDEfGHIJklmNoPq=                               |                  |

> If you replace/re-create the integration you will need to update the trust relationship on AWS

From AWS IAM, find you role previously created click edit trust relationship

```json
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "",
      "Effect": "Allow",
      "Principal": {
        "AWS": "arn:aws:iam::210099933126:user/r7j20000-s"
      },
      "Action": "sts:AssumeRole",
      "Condition": {
        "StringEquals": {
          "sts:ExternalId": "AE97553_SFCRole=2_Y7T5SdDyPXHnVix84qzt9VbrNzA="
        }
      }
    }
  ]
}
```

```sql
grant create stage on schema public to role myrole;
grant usage on integration S3_Integration to role myrole;

-- My role is your snowflake user role e.g. ACCOUNTADMIN

```

arn:aws:iam::166008239929:user/1zr20000-s

### CREATE STAGE 
 
```sql
create or replace stage AssociationStageTest
storage_integration = S3_Integration
url='s3://dg-nz-dev-ingestion/Snowflake/' 
FILE_FORMAT = (FORMAT_NAME =my_parquet_format);
```


### Common Issues

Failure using stage area. Cause: Access Denied (Status Code: 403; Error Code: AccessDenied)

