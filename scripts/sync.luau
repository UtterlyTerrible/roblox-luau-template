local sync = require("./lib/sync")

sync {
    sourcemap_project = "default.project.json",
    sync_project = "build.project.json",
    out = "out",
}
