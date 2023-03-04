import gleam/uri
import nakai
import nakai/html
import gitcove/pages/repo
import gitcove/pages/user

pub fn app(url: String) -> String {
  let assert Ok(url) = uri.parse(url)

  let html = case uri.path_segments(url.path) {
    [owner, repo, "tree", ref] -> repo.page(owner, repo, ref, [])
    [owner, repo, "tree", ref, ..path] -> repo.page(owner, repo, ref, path)
    [owner, repo] -> repo.page(owner, repo, "HEAD", [])
    [owner] -> user.page(owner)
    _ -> html.h1_text([], "404")
  }

  html
  |> nakai.render
}
