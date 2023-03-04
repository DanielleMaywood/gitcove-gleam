import gleam/list
import nakai/html.{Node}
import nakai/html/attrs.{Attr}
import gitcove/utilities/nakai.{with_list}
import gitcove/utilities/nakai/node
import gitcove/utilities/nakai/with
import gitcove/utilities.{cond}

pub type Crumb {
  Crumb(name: String, link: String)
}

pub fn breadcrumb(attrs: List(Attr(a)), crumbs: List(Crumb)) -> Node(a) {
  use <- with_list(attrs)
  use <- with.class("flex flex-row gap-1")

  node.div({
    use i, crumb <- list.index_map(crumbs)

    cond(
      when: i == list.length(crumbs) - 1,
      then: node.div_text(crumb.name),
      else: html.Fragment([
        {
          use <- with.class("text-primary hover:underline")
          use <- with.href(crumb.link)

          node.a_text(crumb.name)
        },
        node.div_text("/"),
      ]),
    )
  })
}
