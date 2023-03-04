import nakai/html.{Node}
import gitcove/templates/base

pub fn page(user: String) -> Node(a) {
  base.document([html.div_text([], user)])
}
