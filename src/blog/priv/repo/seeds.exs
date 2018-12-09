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
Blog.Repo.insert!(%Blog.BlogContext.User{email: "a.mustermann@local.wtl.de", name: "Anna Mustermann"})
Blog.Repo.insert!(%Blog.BlogContext.User{email: "uko@local.wtl.de", name: "Uwe Kowalsky"})
