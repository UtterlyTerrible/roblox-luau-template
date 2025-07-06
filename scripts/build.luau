local build = require("./lib/build")

build {
    sourcemap_project = "default.project.json",
    build_project = "build.project.json",
    out = "game.rbxlx",
}
