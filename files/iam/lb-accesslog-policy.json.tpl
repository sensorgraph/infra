{
  "Id": "Policy",
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "s3:PutObject"
      ],
      "Effect": "Allow",
      "Resource": "arn:aws:s3:::${bucket_name}/*",
      "Principal": {
        "AWS": [
          "${lb_account_arn}"
        ]
      }
    }
  ]
}