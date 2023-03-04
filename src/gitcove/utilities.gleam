pub fn cond(when when: Bool, then then: a, else else: a) -> a {
  case when {
    True -> then
    False -> else
  }
}
