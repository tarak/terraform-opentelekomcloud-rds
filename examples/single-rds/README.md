# single RDS

Configuration in this directory create a single PostgreSQL RDS in an existing VPC.

## Usage

To run this example you need execute:

```bash
$ terraform init
$ terraform plan
$ terraform apply
```

Note that this example may create resources which can cost money. Run `terraform destroy` when you don't need these resources.

##
## Notes

If you recently destroy a RDS Ressouce togehter with a kms key the deletion of the KMS key
will need about 14days. If you need to recreate a new RDS Instance just
 - Cancel deletion
 - import the current KMS Key into the module
   e.g
   ```
   terraform import module.rds.opentelekomcloud_kms_key_v1.this[0]  5112e6b1-34b3-4960-8b2f-ef4f49f40592
   ```
   where terraform import `5112e6b1-34b3-4960-8b2f-ef4f49f40592` is the id of the kms key

## Common pitfalls

- root password is not complex enough
  - must be from 8 - 32 characters
  - must contain digit uppercase and lowercase letter
  - must contain some special characters

## Flavors values


 - PostgreSQL
  ```
  ha = True:
  rds.pg.m1.2xlarge.ha rds.pg.c2.large.ha rds.pg.s1.2xlarge.ha rds.pg.c2.xlarge.ha rds.pg.s1.xlarge.ha rds.pg.m1.xlarge.ha rds.pg.m1.large.ha rds.pg.c2.medium.ha rds.pg.s1.medium.ha rds.pg.s1.large.ha
  ha = False:
  rds.pg.s1.xlarge rds.pg.m1.2xlarge rds.pg.c2.xlarge rds.pg.s1.medium rds.pg.c2.medium rds.pg.s1.large rds.pg.c2.large rds.pg.m1.large rds.pg.s1.2xlarge rds.pg.m1.xlarge
  ```

 - MySQL
 ```
 ha = True:
 rds.mysql.s1.medium.ha rds.mysql.s1.large.ha rds.mysql.s1.xlarge.ha rds.mysql.s1.2xlarge.ha rds.mysql.s1.8xlarge.ha rds.mysql.s1.4xlarge.ha rds.mysql.m1.2xlarge.ha rds.mysql.c2.medium.ha rds.mysql.c2.large.ha rds.mysql.c2.xlarge.ha rds.mysql.c2.2xlarge.ha rds.mysql.c2.4xlarge.ha rds.mysql.c2.8xlarge.ha rds.mysql.m1.medium.ha rds.mysql.m1.large.ha rds.mysql.m1.xlarge.ha rds.mysql.m1.4xlarge.ha
 ha = False:
 rds.mysql.s1.medium rds.mysql.s1.large rds.mysql.s1.xlarge rds.mysql.s1.2xlarge rds.mysql.s1.8xlarge rds.mysql.s1.4xlarge rds.mysql.m1.2xlarge rds.mysql.c2.medium rds.mysql.c2.large rds.mysql.c2.xlarge rds.mysql.c2.2xlarge rds.mysql.c2.4xlarge rds.mysql.c2.8xlarge rds.mysql.m1.medium rds.mysql.m1.large rds.mysql.m1.xlarge rds.mysql.m1.4xlarge
 ```

 - have look at `https://www.terraform.io/docs/providers/huaweicloud/d/rds_flavors_v1.html`
