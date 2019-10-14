alias ToDoList.Repo
alias ToDoList.Accounts
alias ToDoList.ToDoLists

user =
  Accounts.User.changeset(%Accounts.User{}, %{
    username: "paulor",
    email: "paulor1809@gmail.com",
    virtual_password: "12345678",
    virtual_password_confirmation: "12345678"
  })
  |> Repo.insert!()

user2 =
  Accounts.User.changeset(%Accounts.User{}, %{
    username: "test",
    email: "test@gmail.com",
    virtual_password: "12345678",
    virtual_password_confirmation: "12345678"
  })
  |> Repo.insert!()

challenge_task =
  %ToDoLists.Task{
    owner: user.id,
    title: "Challenge ToDoList elixir/phoenix",
    public: true
  }
  |> Repo.insert!()

%ToDoLists.TaskItem{
  task_id: challenge_task.id,
  title: "US01 - User Sign In - Priority: 1",
  done: true
}
|> Repo.insert!()

%ToDoLists.TaskItem{
  task_id: challenge_task.id,
  title: "US06 - Landing Page - Priority: 1",
  done: true
}
|> Repo.insert!()

%ToDoLists.TaskItem{
  task_id: challenge_task.id,
  title: "US10 - Create to-do list - Priority: 1",
  done: true
}
|> Repo.insert!()

%ToDoLists.TaskItem{
  task_id: challenge_task.id,
  title: "US14 - User Sign Up - Priority: 1",
  done: true
}
|> Repo.insert!()

%ToDoLists.TaskItem{
  task_id: challenge_task.id,
  title: "US16 - Add task to list - Priority: 1",
  done: true
}
|> Repo.insert!()

%ToDoLists.TaskItem{
  task_id: challenge_task.id,
  title: "US04 - Mark as done/undone - Priority: 2",
  done: true
}
|> Repo.insert!()

%ToDoLists.TaskItem{
  task_id: challenge_task.id,
  title: "US17 - Public to-do lists page - Priority: 2",
  done: true
}
|> Repo.insert!()

%ToDoLists.TaskItem{
  task_id: challenge_task.id,
  title: "US03 - Edit tasks - Priority: 3",
  done: true
}
|> Repo.insert!()

%ToDoLists.TaskItem{
  task_id: challenge_task.id,
  title: "US05 - Remove tasks - Priority: 3",
  done: true
}
|> Repo.insert!()

%ToDoLists.TaskItem{
  task_id: challenge_task.id,
  title: "US11 - Remove todo-list - Priority: 3",
  done: true
}
|> Repo.insert!()

%ToDoLists.TaskItem{
  task_id: challenge_task.id,
  title: "US12 - View to-do lists - Priority: 3",
  done: true
}
|> Repo.insert!()

%ToDoLists.TaskItem{
  task_id: challenge_task.id,
  title: "US02 - User's favorite to-do lists - Priority: 4",
  done: true
}
|> Repo.insert!()

%ToDoLists.TaskItem{
  task_id: challenge_task.id,
  title: "US07 - Edit user's account - Priority: 4",
  done: true
}
|> Repo.insert!()

%ToDoLists.TaskItem{
  task_id: challenge_task.id,
  title: "US08 - Recover user account - Priority: 4",
  done: true
}
|> Repo.insert!()

%ToDoLists.TaskItem{
  task_id: challenge_task.id,
  title: "US09 - Favorite to-do list - Priority: 4",
  done: true
}
|> Repo.insert!()

%ToDoLists.TaskItem{
  task_id: challenge_task.id,
  title: "US15 - Unfavorite a to-do list - Priority: 4",
  done: true
}
|> Repo.insert!()

%ToDoLists.TaskItem{
  task_id: challenge_task.id,
  title: "US13 - User's profile page - Priority: 4",
  done: true
}
|> Repo.insert!()

%ToDoLists.TaskItem{
  task_id: challenge_task.id,
  title: "US18 - Highlight the current page - Priority: 5",
  done: true
}
|> Repo.insert!()

advent_of_code =
  %ToDoLists.Task{
    owner: user.id,
    title: "Advent of code 2018",
    public: true
  }
  |> Repo.insert!()

Enum.each(1..25, fn day ->
  %ToDoLists.TaskItem{
    task_id: advent_of_code.id,
    title: "Day #{day}"
  }
  |> Repo.insert!()
end)

test =
  %ToDoLists.Task{
    owner: user2.id,
    title: "Test",
    public: true
  }
  |> Repo.insert!()

Enum.each(1..10, fn count ->
  %ToDoLists.TaskItem{
    task_id: test.id,
    title: "Test #{count}",
    done: rem(count, 2) == 0
  }
  |> Repo.insert!()
end)
