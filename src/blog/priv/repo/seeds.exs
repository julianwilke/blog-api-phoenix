# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Blog.Repo.insert!(%Blog.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.
Blog.Repo.insert!(%Blog.Blogs.User{email: "a.mustermann@local.wtl.de", name: "Anna Mustermann", token: "1237ef3f-5393-4710-a682-49b3d8c47789"})
Blog.Repo.insert!(%Blog.Blogs.User{email: "uko@local.wtl.de", name: "Uwe Kowalsky", token: "8f07ef3f-5393-4710-a682-49b3d8c47c0a"})
