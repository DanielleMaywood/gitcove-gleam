import nakai/html.{Node}
import gitcove/utilities/nakai.{node}

pub fn div(children: List(Node(a))) -> Node(a) {
  node(html.div, children)
}

pub fn div_text(value: String) -> Node(a) {
  node(html.div_text, value)
}

pub fn a_text(value: String) -> Node(a) {
  node(html.a_text, value)
}

pub fn code_text(value: String) -> Node(a) {
  node(html.code_text, value)
}

pub fn nav(children: List(Node(a))) -> Node(a) {
  node(html.nav, children)
}

pub fn table(children: List(Node(a))) -> Node(a) {
  node(html.table, children)
}

pub fn tbody(children: List(Node(a))) -> Node(a) {
  node(html.tbody, children)
}

pub fn tr(children: List(Node(a))) -> Node(a) {
  node(html.tr, children)
}

pub fn td(children: List(Node(a))) -> Node(a) {
  node(html.td, children)
}

pub fn td_text(value: String) -> Node(a) {
  node(html.td_text, value)
}

pub fn ul(children: List(Node(a))) -> Node(a) {
  node(html.ul, children)
}

pub fn pre(children: List(Node(a))) -> Node(a) {
  node(html.pre, children)
}
