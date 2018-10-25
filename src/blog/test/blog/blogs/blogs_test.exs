defmodule Blog.BlogsTest do
  use Blog.DataCase

  alias Blog.Blogs

  describe "users" do
    alias Blog.Blogs.User

    @valid_attrs %{email: "some email", name: "some name", token: "7488a646-e31f-11e4-aace-600308960662"}
    @update_attrs %{email: "some updated email", name: "some updated name", token: "7488a646-e31f-11e4-aace-600308960668"}
    @invalid_attrs %{email: nil, name: nil, token: nil}

    def user_fixture(attrs \\ %{}) do
      {:ok, user} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Blogs.create_user()

      user
    end

    test "list_users/0 returns all users" do
      user = user_fixture()
      assert Blogs.list_users() == [user]
    end

    test "get_user!/1 returns the user with given id" do
      user = user_fixture()
      assert Blogs.get_user!(user.id) == user
    end

    test "create_user/1 with valid data creates a user" do
      assert {:ok, %User{} = user} = Blogs.create_user(@valid_attrs)
      assert user.email == "some email"
      assert user.name == "some name"
      assert user.token == "7488a646-e31f-11e4-aace-600308960662"
    end

    test "create_user/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Blogs.create_user(@invalid_attrs)
    end

    test "update_user/2 with valid data updates the user" do
      user = user_fixture()
      assert {:ok, user} = Blogs.update_user(user, @update_attrs)
      assert %User{} = user
      assert user.email == "some updated email"
      assert user.name == "some updated name"
      assert user.token == "7488a646-e31f-11e4-aace-600308960668"
    end

    test "update_user/2 with invalid data returns error changeset" do
      user = user_fixture()
      assert {:error, %Ecto.Changeset{}} = Blogs.update_user(user, @invalid_attrs)
      assert user == Blogs.get_user!(user.id)
    end

    test "delete_user/1 deletes the user" do
      user = user_fixture()
      assert {:ok, %User{}} = Blogs.delete_user(user)
      assert_raise Ecto.NoResultsError, fn -> Blogs.get_user!(user.id) end
    end

    test "change_user/1 returns a user changeset" do
      user = user_fixture()
      assert %Ecto.Changeset{} = Blogs.change_user(user)
    end
  end

  describe "posts" do
    alias Blog.Blogs.Post

    @valid_attrs %{message: "some message"}
    @update_attrs %{message: "some updated message"}
    @invalid_attrs %{message: nil}

    def post_fixture(attrs \\ %{}) do
      {:ok, post} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Blogs.create_post()

      post
    end

    test "list_posts/0 returns all posts" do
      post = post_fixture()
      assert Blogs.list_posts() == [post]
    end

    test "get_post!/1 returns the post with given id" do
      post = post_fixture()
      assert Blogs.get_post!(post.id) == post
    end

    test "create_post/1 with valid data creates a post" do
      assert {:ok, %Post{} = post} = Blogs.create_post(@valid_attrs)
      assert post.message == "some message"
    end

    test "create_post/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Blogs.create_post(@invalid_attrs)
    end

    test "update_post/2 with valid data updates the post" do
      post = post_fixture()
      assert {:ok, post} = Blogs.update_post(post, @update_attrs)
      assert %Post{} = post
      assert post.message == "some updated message"
    end

    test "update_post/2 with invalid data returns error changeset" do
      post = post_fixture()
      assert {:error, %Ecto.Changeset{}} = Blogs.update_post(post, @invalid_attrs)
      assert post == Blogs.get_post!(post.id)
    end

    test "delete_post/1 deletes the post" do
      post = post_fixture()
      assert {:ok, %Post{}} = Blogs.delete_post(post)
      assert_raise Ecto.NoResultsError, fn -> Blogs.get_post!(post.id) end
    end

    test "change_post/1 returns a post changeset" do
      post = post_fixture()
      assert %Ecto.Changeset{} = Blogs.change_post(post)
    end
  end

  describe "comments" do
    alias Blog.Blogs.Comment

    @valid_attrs %{message: "some message"}
    @update_attrs %{message: "some updated message"}
    @invalid_attrs %{message: nil}

    def comment_fixture(attrs \\ %{}) do
      {:ok, comment} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Blogs.create_comment()

      comment
    end

    test "list_comments/0 returns all comments" do
      comment = comment_fixture()
      assert Blogs.list_comments() == [comment]
    end

    test "get_comment!/1 returns the comment with given id" do
      comment = comment_fixture()
      assert Blogs.get_comment!(comment.id) == comment
    end

    test "create_comment/1 with valid data creates a comment" do
      assert {:ok, %Comment{} = comment} = Blogs.create_comment(@valid_attrs)
      assert comment.message == "some message"
    end

    test "create_comment/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Blogs.create_comment(@invalid_attrs)
    end

    test "update_comment/2 with valid data updates the comment" do
      comment = comment_fixture()
      assert {:ok, comment} = Blogs.update_comment(comment, @update_attrs)
      assert %Comment{} = comment
      assert comment.message == "some updated message"
    end

    test "update_comment/2 with invalid data returns error changeset" do
      comment = comment_fixture()
      assert {:error, %Ecto.Changeset{}} = Blogs.update_comment(comment, @invalid_attrs)
      assert comment == Blogs.get_comment!(comment.id)
    end

    test "delete_comment/1 deletes the comment" do
      comment = comment_fixture()
      assert {:ok, %Comment{}} = Blogs.delete_comment(comment)
      assert_raise Ecto.NoResultsError, fn -> Blogs.get_comment!(comment.id) end
    end

    test "change_comment/1 returns a comment changeset" do
      comment = comment_fixture()
      assert %Ecto.Changeset{} = Blogs.change_comment(comment)
    end
  end
end
