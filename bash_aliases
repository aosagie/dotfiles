function cd() {
    builtin cd "$*" && ls
}
