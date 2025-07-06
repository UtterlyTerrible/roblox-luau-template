-- #selene:allow(undefined_variable)
-- #selene:allow(incorrect_standard_library_use)
local Process = require("./util/Process")
local std = require("@std")
local fs = zune.fs
local task = zune.task

local function sync(options: {
    sourcemap_project: string,
    sync_project: string,
    out: string,
})
    Process.new("pesde"):argument("install"):option("stdio", "inherit"):run()
    task.spawn(function()
        local origin_metadata = fs.metadata("pesde.toml")
        assert(origin_metadata)

        local last_modified = origin_metadata.modifiedAt

        while true do
            task.wait(1)

            local metadata = fs.metadata("pesde.toml")
            if not metadata then
                continue
            end

            if last_modified < metadata.modifiedAt then
                last_modified = metadata.modifiedAt
                Process.new("pesde")
                    :argument("install")
                    :option("stdio", "inherit")
                    :run()
            end
        end
    end)

    Process.new("rojo")
        :argument("sourcemap")
        :argument(options.sourcemap_project)
        :argument("-o")
        :argument("sourcemap.json")
        :argument("--watch")
        :option("stdio", "inherit")
        :spawn()

    Process.new("darklua")
        :argument("process")
        :argument("--config")
        :argument(".darklua.json")
        :argument("--watch")
        :argument("src/")
        :argument(options.out)
        :option("env", {
            ROBLOX_DEV = "true",
        })
        :option("stdio", "inherit")
        :spawn()

    Process.new("rojo")
        :argument("serve")
        :argument(options.sync_project)
        :option("stdio", "inherit")
        :spawn()

    print(
        `{std.ansi.green}{std.ansi.bold}[scripts]{std.ansi.reset} Syncing \`src/\` -> \`out/\` -> \`127.0.0.1:34872\``
    )
end

return sync
