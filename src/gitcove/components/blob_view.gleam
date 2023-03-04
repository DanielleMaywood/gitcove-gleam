import nakai/html.{Node}
import gitcove/utilities/nakai/with
import gitcove/utilities/nakai/node

pub fn blob_view(blob: String) -> Node(a) {
  use <- with.class("bg-base-200 py-2 px-3 overflow-x-auto")

  node.pre([node.code_text(blob)])
}
