resource "aws_iam_user" "adminuser1" {
    name = "adminuser1"
      tags = {
        Name = "adminuser1"
    }
  
}

resource "aws_iam_user" "adminuser2" {
    name = "adminuser2"
      tags = {
        Name = "adminuser2"
    }
}

#GROUP
resource "aws_iam_group" "admingroup" {
  name = "admingroup"

}

#assign user to group
resource "aws_iam_group_membership" "admin-users" {
  name = "admin-users"
  users = [
    aws_iam_user.adminuser1.name,
    aws_iam_user.adminuser2.name
  ]
  group = aws_iam_group.admingroup.name
}

#policy for aws group
resource "aws_iam_policy_attachment" "admin-users-attach" {
  name = "admin-user-attach"
  groups = [aws_iam_group.admingroup.name]
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}