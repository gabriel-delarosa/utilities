## IAM Scripts
---
### Table of Content:
1. [Get IAM Role Policies](#GET-IAM-Role-Policies)

---

### GET IAM Role Policies

#### Description:

Bash scripts that allows you to get Json Documents for Inline and Managed policies attached to a given IAM Role

#### Prerequisites:
- Bash
- AWS Programatic Access

#### Usage:
> Get the scripts from iam-polcies folder

Inline Policies:
```
$] ./get_inline_policies_json_doc.sh < IAM Role Name >
```

Managed Policies:
```
$] ./get_managed_policies_json_doc.sh < IAM Role Name >
```

#### Example Outputs:
Inline:
```
Policy Document for: S3_bucket_Access
{
    "RoleName": "S3WriteAccess",
    "PolicyName": "S3_bucket_Access",
    "PolicyDocument": {
        "Version": "2012-10-17",
        "Statement": [
            {
                "Sid": "VisualEditor0",
                "Effect": "Allow",
                "Action": [
                    "s3:PutObject",
                    "s3:GetObject"
                ],
                "Resource": [
                    "arn:aws:s3:::some_s3_bucket/*",
                ]
            },
            {
                "Sid": "VisualEditor1",
                "Effect": "Allow",
                "Action": "s3:ListBucket",
                "Resource": [
                    "arn:aws:s3:::some_s3_bucket",
                ],
            }
        ]
    }
}
...
```
Managed:
```
Policy Document for: arn:aws:iam::aws:policy/AmazonSESFullAccess
{
    "PolicyVersion": {
        "Document": {
            "Version": "2012-10-17",
            "Statement": [
                {
                    "Effect": "Allow",
                    "Action": [
                        "ses:*"
                    ],
                    "Resource": "*"
                }
            ]
        },
        "VersionId": "v1",
        "IsDefaultVersion": true,
        "CreateDate": "2015-02-06T18:41:02+00:00"
    }
}
...
```
