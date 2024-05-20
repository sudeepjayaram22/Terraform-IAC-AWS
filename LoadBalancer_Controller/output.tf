# Load Balancer Controller Outputs:
output "aws_load_balancer_controller_id" {
  value = aws_iam_role.aws_load_balancer_controller.id
}

output "aws_load_balancer_controller_name" {
  value = aws_iam_role.aws_load_balancer_controller.name
}

output "aws_load_balancer_controller_name_prefix" {
  value = aws_iam_role.aws_load_balancer_controller.name_prefix
}

output "aws_load_balancer_controller_role_arn" {
  value = aws_iam_role.aws_load_balancer_controller.arn
}

output "aws_load_balancer_controller_create_date" {
  value = aws_iam_role.aws_load_balancer_controller.create_date
}

output "aws_load_balancer_controller_description" {
  value = aws_iam_role.aws_load_balancer_controller.description
}

output "aws_load_balancer_controller_force_detach_policies" {
  value = aws_iam_role.aws_load_balancer_controller.force_detach_policies
}

output "aws_load_balancer_controller_managed_policy_arns" {
  value = aws_iam_role.aws_load_balancer_controller.managed_policy_arns
}

output "aws_load_balancer_controller_max_session_duration" {
  value = aws_iam_role.aws_load_balancer_controller.max_session_duration
}

output "aws_load_balancer_controller_path" {
  value = aws_iam_role.aws_load_balancer_controller.path
}

output "aws_load_balancer_controller_permissions_boundary" {
  value = aws_iam_role.aws_load_balancer_controller.permissions_boundary
}

output "aws_load_balancer_controller_assume_role_policy" {
  value = aws_iam_role.aws_load_balancer_controller.assume_role_policy
}

output "aws_load_balancer_controller_tags" {
  value = aws_iam_role.aws_load_balancer_controller.tags
}

output "aws_load_balancer_controller_tags_all" {
  value = aws_iam_role.aws_load_balancer_controller.tags_all
}

# Helm Release Outputs:
output "helm_lb_controller_name" {
  value = helm_release.aws-load-balancer-controller.name
}

output "helm_lb_controller_cleanup_on_fail" {
  value = helm_release.aws-load-balancer-controller.cleanup_on_fail
}

output "helm_lb_controller_atomic" {
  value = helm_release.aws-load-balancer-controller.atomic
}

output "helm_lb_controller_chart" {
  value = helm_release.aws-load-balancer-controller.chart
}

output "helm_lb_controller_create_namespace" {
  value = helm_release.aws-load-balancer-controller.create_namespace
}

output "helm_lb_controller_dependency_update" {
  value = helm_release.aws-load-balancer-controller.dependency_update
}

output "helm_lb_controller_devel" {
  value = helm_release.aws-load-balancer-controller.devel
}

output "helm_lb_controller_description" {
  value = helm_release.aws-load-balancer-controller.description
}

output "helm_lb_controller_disable_crd_hooks" {
  value = helm_release.aws-load-balancer-controller.disable_crd_hooks
}

output "helm_lb_controller_disable_openapi_validation" {
  value = helm_release.aws-load-balancer-controller.disable_openapi_validation
}

output "helm_lb_controller_disable_webhooks" {
  value = helm_release.aws-load-balancer-controller.disable_webhooks
}

output "helm_lb_controller_force_update" {
  value = helm_release.aws-load-balancer-controller.force_update
}

output "helm_lb_controller_id" {
  value = helm_release.aws-load-balancer-controller.id
}

output "helm_lb_controller_keyring" {
  value = helm_release.aws-load-balancer-controller.keyring
}

output "helm_lb_controller_lint" {
  value = helm_release.aws-load-balancer-controller.lint
}

output "helm_lb_controller_manifest" {
  value = helm_release.aws-load-balancer-controller.manifest
}

output "helm_lb_controller_max_history" {
  value = helm_release.aws-load-balancer-controller.max_history
}

output "helm_lb_controller_metadata" {
  value = helm_release.aws-load-balancer-controller.metadata
}

output "helm_lb_controller_namespace" {
  value = helm_release.aws-load-balancer-controller.namespace
}

output "helm_lb_controller_pass_credentials" {
  value = helm_release.aws-load-balancer-controller.pass_credentials
}

output "helm_lb_controller_recreate_pods" {
  value = helm_release.aws-load-balancer-controller.recreate_pods
}

output "helm_lb_controller_replace" {
  value = helm_release.aws-load-balancer-controller.replace
}

output "helm_lb_controller_repository" {
  value = helm_release.aws-load-balancer-controller.repository
}

output "helm_lb_controller_repository_ca_file" {
  value = helm_release.aws-load-balancer-controller.repository_ca_file
}

output "helm_lb_controller_repository_cert_file" {
  value = helm_release.aws-load-balancer-controller.repository_cert_file
}

output "helm_lb_controller_repository_key_file" {
  value = helm_release.aws-load-balancer-controller.repository_key_file
}

output "helm_lb_controller_repository_password" {
  value = helm_release.aws-load-balancer-controller.repository_password
  sensitive = true
}

output "helm_lb_controller_repository_username" {
  value = helm_release.aws-load-balancer-controller.repository_username
}

output "helm_lb_controller_set" {
  value = helm_release.aws-load-balancer-controller.set
}

output "helm_lb_controller_skip_crds" {
  value = helm_release.aws-load-balancer-controller.skip_crds
}

output "helm_lb_controller_status" {
  value = helm_release.aws-load-balancer-controller.status
}

output "helm_lb_controller_timeout" {
  value = helm_release.aws-load-balancer-controller.timeout
}

output "helm_lb_controller_values" {
  value = helm_release.aws-load-balancer-controller.values
}

output "helm_lb_controller_verify" {
  value = helm_release.aws-load-balancer-controller.verify
}

output "helm_lb_controller_version" {
  value = helm_release.aws-load-balancer-controller.version
}

output "helm_lb_controller_wait" {
  value = helm_release.aws-load-balancer-controller.wait
}

output "helm_lb_controller_wait_for_jobs" {
  value = helm_release.aws-load-balancer-controller.wait_for_jobs
}
