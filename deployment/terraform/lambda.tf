module "lambda_release_index_generator" {
  source                            = "terraform-aws-modules/lambda/aws"
  version                           = "~> 1.22"
  function_name                     = "release_index_generator"
  description                       = "Lambda for generate index.html files for releases.fivexl.io bucket"
  handler                           = "index.lambda_handler"
  runtime                           = "nodejs12.x"
  source_path                       = "../lambda/release_index_generator"
  cloudwatch_logs_retention_in_days = 7
  publish                           = true
  allowed_triggers = {
    S3 = {
      principal      = "s3.amazonaws.com"
      source_arn     = module.release_bucket.this_s3_bucket_arn
      source_account = data.aws_caller_identity.current.account_id
    }
  }
  tags = {
    Name = "release_index_generator"
  }
}

