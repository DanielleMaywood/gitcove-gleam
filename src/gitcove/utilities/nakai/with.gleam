import nakai/html.{Node}
import nakai/html/attrs
import gitcove/utilities/nakai.{with}

pub fn class(value: String, builder: fn() -> Node(a)) -> Node(a) {
  with(attrs.class(value), builder)
}

pub fn style(value: String, builder: fn() -> Node(a)) -> Node(a) {
  with(attrs.style(value), builder)
}

pub fn href(value: String, builder: fn() -> Node(a)) -> Node(a) {
  with(attrs.href(value), builder)
}
