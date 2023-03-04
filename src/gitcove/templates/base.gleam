import nakai/html.{Node}
import nakai/html/attrs
import gitcove/components/header.{header}

pub fn document(children: List(Node(a))) -> Node(a) {
  html.Fragment([
    html.head([html.meta([attrs.name("twind")])]),
    html.body(
      [],
      [
        header(),
        html.main([attrs.class("container mx-auto px-8 py-4")], children),
      ],
    ),
  ])
}
