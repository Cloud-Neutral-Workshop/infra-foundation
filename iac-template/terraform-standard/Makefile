# ---------------------------------------------------------
# Root Makefile - orchestrate bootstrap modules
# ---------------------------------------------------------

BOOTSTRAP_S3_DIR        = bootstrap-s3
BOOTSTRAP_DYNAMODB_DIR  = bootstrap-dynamodb
BOOTSTRAP_IAM_DIR       = bootstrap-iam

# --------------------------------------------
# Bootstrap targets
# --------------------------------------------

bootstrap: bootstrap-s3 bootstrap-dynamodb bootstrap-iam
	@echo "🎉 All bootstrap modules completed."

bootstrap-s3:
	make -C $(BOOTSTRAP_S3_DIR) bootstrap

bootstrap-dynamodb:
	make -C $(BOOTSTRAP_DYNAMODB_DIR) bootstrap

bootstrap-iam:
	make -C $(BOOTSTRAP_IAM_DIR) bootstrap

# --------------------------------------------
# Run all bootstraps in order
# --------------------------------------------


bootstrap-plan:
	make -C $(BOOTSTRAP_S3_DIR) plan
	make -C $(BOOTSTRAP_DYNAMODB_DIR) plan
	make -C $(BOOTSTRAP_IAM_DIR) plan


bootstrap-output:
	make -C $(BOOTSTRAP_S3_DIR) output
	make -C $(BOOTSTRAP_DYNAMODB_DIR) output
	make -C $(BOOTSTRAP_IAM_DIR) output

bootstrap-destroy:
	make -C $(BOOTSTRAP_S3_DIR) destroy
	make -C $(BOOTSTRAP_DYNAMODB_DIR) destroy
	make -C $(BOOTSTRAP_IAM_DIR) destroy

bootstrap-reinit: bootstrap-destroy bootstrap
