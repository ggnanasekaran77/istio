#!/usr/bin/env python

import yaml

user_roles = {"{email}+{project}+{role}".format(email=user["email"], project=project["project"], role=role): [
    user["email"], project["project"], role
]
    for user in yaml.safe_load(open("test.yaml", "r"))["safi_devops_users"]
    for project in user["gcp"]["projects_iam"]
    for role in project["roles"]}

for user_role in user_roles.values():
    print(user_role)
