# To-Do List

Have you ever used a to-do list? It's a common application that you can easily find on web, desktop
or even in your phone.

# Challenge

The challenge is to build a to-do list application with some social features. Users can create and share their to-do lists and favorite to-do lists from other users.

The general flow of the application is shown in the GIF at `docs/index.html`.

## User Stories

All user stories(US) have priorities. The priority is a number, lower is the number, higher is the
priority. For example, the US of priority 1 has a higher priority compared to the US of priority 2.
The product owner(PO) expects you to deliver the stories respecting their priorities. You can
implement in any order of your preference, however, when the time is up, the PO expects
higher-priority stories to be delivered. The stories have mockups and support material in the
`docs/` directory. If you need to create new stories, feel free to add more into the backlog using
the same description format.

### US01 - User Sign In - Priority: 1

When I visit the application, I want to fill in my account credentials, so I can create and favorite
to-do lists and track them in my account.

### US02 - User's favorite to-do lists - Priority: 4

When I have favorite to-do lists, I want to visit my Favorite Lists page, so I can view the details of
the to-do lists that I liked.

### US03 - Edit tasks - Priority: 3

When I have tasks, I want to update their description, so I can fix any mistake that I've made
before.

### US04 - Mark as done/undone - Priority: 2

When I have tasks, I want to update their status, so I can track the progress of my goal.

### US05 - Remove tasks - Priority: 3

When I have tasks, I want to remove them, so I can update my goal when the steps change.

### US06 - Landing Page - Priority: 1

When I visit the application, I want to have an initial page, so I can choose what I want to do.

### US07 - Edit user's account - Priority: 4

When I have account, I want to edit my account information, so I can have my contact information
and password up to date.

### US08 - Recover user account - Priority: 4

When I have account and forgot their credentials, I want to recover my account, so I can have access
to my to-do lists again.

### US09 - Favorite to-do list - Priority: 4

When I see a public to-do list that I like, I want to favorite them, so I can easily visit them
later.

### US10 - Create to-do list - Priority: 1

When I have a new goal, I want create a to-do list, so I can add tasks and track progress of my
goal.

### US11 - Remove todo-list - Priority: 3

When I have todo-lists, I want to remove them, so I can keep a list of todo-lists that matters to
me.

### US12 - View to-do lists - Priority: 3

When I see a public to-do list, I want to see their tasks, so I can know more about that to-do list.

### US13 - User's profile page - Priority: 4

When I see a public to-do list, I want to visit the owners page, so I can know more about other to-do lists that user has created.

### US14 - User Sign Up - Priority: 1

When I'm the first time visiting the application, I want to fill my account information, so I can so I can create and favorite to-do lists and track them in my account.

### US15 - Unfavorite a to-do list - Priority: 4

When I have favorite to-do lists, I want to remove them from my favorite list, so I can keep track
only the lists that stills matter to me.

### US16 - Add task to list - Priority: 1

When I have a to-do list, I want to create tasks, so I can see how many steps I need to accomplish
my goal.

### US17 - Public to-do lists page - Priority: 2

When I'm visiting the application, I want to visit the recently created public lists, so I can view
their details, earn some inspiration to create my own or favorite them.

### US18 - Highlight the current page - Priority: 5

When I'm looking at navigation, I want to see which page I'm visiting, so I can localize myself
when I'm looking at navigation.


# Some UI information

In `docs/` directory there some guidelines how the pages should look and which information they
should have. You don't need to make the pages look exactly the same. You have freedom to exercise your creativity since your ideas don't break the User Stories.

 * Suggested colors
   * #EFF3F6
   * #2EA1F8
   * #1990EA
   * #1166A5
   * #FFFFFF
   * #E6EAEE
   * #39B54A
   * #34AA44
   * #249533
   * #1E930B
   * #1E9D09
   * #009DDC
   * #EEEEEE
   * #B54C0D

 * Suggested fonts
   * 'Source Sans Pro' (weights: 300, 400 and 600)
   * sans-serif (fallback)

# Exercise requirements

These are some important requirements for this stage. We'll certainly make a contextual assessment of your app in case they're not fulfilled, but do your best to cover all of them.

* You have to use Elixir and Phoenix for this coding challenge.
* You have to support modern browsers.
 * You don't need to worry about old browsers compatibility.
* Your application must work
   * Think of our team not only as evaluators but also as your customers. Think of your final upload as a deployment and that our evaluation occurs in production. Favor delivering an application that works correctly over one with complete –but broken– features.
* Give us instructions through the `README.md` file
   * We will set up and use your application, so don't forget to add important instructions for us to get your app up and running smoothly.
* Have a useful and informative Git history
   * The provided ZIP file does not include a `.git/` structure, but we expect you to use Git to version changes during the development. You are supposed to produce code upon the provided code. Feel free to change the code, update any dependencies or install new ones.
   * Divide your work into meaningful commits, we'll assess the steps you've taken to build this exercise.
   * You're the only person who must commit in this repository.
* Write tests
   * Tests play a very important role in our technical culture. We value technical excellence, coding good practices and all efforts to deliver high quality software.
   * Do not worry if you're not experienced with the practice, enjoy the opportunity to exercise it.
* Your test suite must be green
   * A red (broken) test suite causes a lot of frustration in teams and makes it harder to deliver value with the software. It may also be a symptom of buggy software. Favor working tests over incomplete tests! Favor working code over failing code!

# Tips

   * The provided code is a boilerplate Elixir/Phoenix app.
   * You're allowed to use a CSS framework, although it's not mandatory. We expect to see your CSS skills either in writing your own or in using a CSS framework appropriately.
   * You can use underscore, jQuery or another JS framework to help with DOM manipulation if you need it.
   * React, Vue.js, Angular and other frameworks are a plus, but not required. If you feel comfortable with them, that's OK. Just pay attention to the limited time you have to accomplish the required features described in the `CHALLENGE.md` file.
   * Keep as close as you can from the templates presented in the `docs/` directory.
   * You don't need to strive for 100% code coverage, focus on meaningful tests.
   * For acceptance tests, you can use [Wallaby](https://github.com/keathley/wallaby).
   * You are allowed to use any Elixir library to help you achieve the project goal.

# What's going to be assessed?

   * Your CSS, JS and HTML skills
   * How you design APIs, controllers, and tests
   * Security issues (pay attention to them!)
   * Organization and zeal for the code
   * Your tests
   * Your Git history
