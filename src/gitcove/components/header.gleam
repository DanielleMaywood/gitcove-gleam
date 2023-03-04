import nakai/html.{Node}
import gitcove/utilities/nakai/node
import gitcove/utilities/nakai/with

fn navigation_link(href href: String, name name: String) -> Node(a) {
  use <- with.class("px-3 py-2 rounded hover:bg-base-300")
  use <- with.href(href)

  node.a_text(name)
}

fn navigation() -> Node(a) {
  node.nav([
    {
      use <- with.class("flex items-center gap-1")

      node.ul([
        navigation_link(href: "/register", name: "Register"),
        navigation_link(href: "/login", name: "Login"),
      ])
    },
  ])
}

fn branding() -> Node(a) {
  use <- with.class("flex items-center flex-1")

  node.div([
    {
      use <- with.class("text-2xl ml-1 font-bold")

      node.div_text("GitCove")
    },
  ])
}

pub fn header() -> Node(a) {
  use <- with.class("bg-base-200 text-base-content")

  node.div([
    {
      use <- with.class("container mx-auto flex flex-row px-8 py-2")

      node.div([branding(), navigation()])
    },
  ])
}
