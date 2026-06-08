TERRAFORM = docker compose run --rm -it terraform

terraform:
  @$(TERRAFORM) $(filter-out $@,$(MAKECMDGOALS))

%:
  @:
