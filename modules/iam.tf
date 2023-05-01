resource "aws_iam_user" "iam_user_tf" {
  name = "iam_user_tf"
  tags = {
    Name = "Terraform User"
  }
}

resource "aws_iam_user_policy_attachment" "terraform_user_policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2FullAccess"
  user       = aws_iam_user.iam_user_tf.name
}

resource "aws_iam_user" "iam_user_tf" {
  name = "iam_tf"
}

resource "aws_iam_access_key" "iam_user_tf" {
  user = aws_iam_user.iam_user_tf.name
}

output "access_key" {
  value = aws_iam_access_key.iam_user_tf.id
}

output "secret_key" {
  value = aws_iam_access_key.iam_user_tf.secret
}
