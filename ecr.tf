resource "aws_ecr_repository" "akiko_redmine_banner" {
  name = "akiko/redmine_banner"
}

resource "aws_ecr_lifecycle_policy" "akiko_redmine_banner_policy" {
  policy = jsonencode(
    {
      rules = [
        {
          action = {
            type = "expire"
          }
          description  = "最新の1つを残してイメージを削除する"
          rulePriority = 1
          selection = {
            countNumber = 1
            countType   = "imageCountMoreThan"
            tagStatus   = "any"
          }
        },
      ]
    }
  )
  repository = "${aws_ecr_repository.akiko_redmine_banner.name}"
}