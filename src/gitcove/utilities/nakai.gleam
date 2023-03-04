import gleam/list
import nakai/html.{Element, Node}
import nakai/html/attrs.{Attr}

pub fn node(builder: fn(List(Attr(a)), b) -> Node(a), children: b) -> Node(a) {
  builder([], children)
}

pub fn with(attr: Attr(a), builder: fn() -> Node(a)) -> Node(a) {
  with_list([attr], builder)
}

pub fn with_list(new_attrs: List(Attr(a)), builder: fn() -> Node(a)) -> Node(a) {
  case builder() {
    Element(tag, attrs, children) ->
      Element(tag, list.append(new_attrs, attrs), children)
    _ -> panic
  }
}
