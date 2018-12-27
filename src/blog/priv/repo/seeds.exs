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
Blog.Repo.insert!(%Blog.BlogContext.User{email: "a.mustermann@local.wtl.de", name: "Anna Mustermann", token: "e9e4b1fe-9feb-4958-8648-8f6d5ac64aee"})
Blog.Repo.insert!(%Blog.BlogContext.User{email: "uko@local.wtl.de", name: "Uwe Kowalsky", token: "441985d8-bc20-46af-b108-505d7770b068"})
