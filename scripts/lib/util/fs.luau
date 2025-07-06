-- #selene:allow(undefined_variable)
-- #selene:allow(incorrect_standard_library_use)
local fs = zune.fs

local function exists(path: string): boolean
    local _, res = pcall(fs.readDir, path)
    return res ~= "FileNotFound"
end

local function ensure_dirs(dirs: { string })
    for _, dir in dirs do
        if exists(dir) and fs.isDir(dir) then
            continue
        end
        fs.writeDir(dir, true)
    end
end

local function remove(path: string, recursive: boolean?)
    if fs.isDir(path) then
        fs.removeDir(path, recursive)
        return
    end
    fs.removeFile(path)
end

local function remove_safe(path: string, recursive: boolean?)
    if not exists(path) then
        return
    end
    remove(path, recursive)
end

local function mime_folders(paths: { string }): () -> ()
    local acting: { [string]: true } = {}
    for _, path in paths do
        if fs.isDir(path) then
            continue
        end
        fs.writeDir(path)
        acting[path] = true
    end

    local function cleanup()
        for path in acting do
            fs.removeDir(path)
        end
    end

    return cleanup
end

local function traverse(
    dir: string,
    fn: (
        path: string,
        name: string,
        metadata: Metadata
    ) -> ()
)
    assert(fs.isDir(dir))

    for _, name in fs.readDir(dir) do
        local path = `{dir}/{name}`
        local child = fs.metadata(path)
        if not child then
            continue
        end

        fn(path, name, child)
        if child.kind == "dir" then
            traverse(path, fn)
            continue
        end
    end
end

return {
    exists = exists,
    ensure_dirs = ensure_dirs,
    remove = remove,
    remove_safe = remove_safe,
    mime_folders = mime_folders,
    traverse = traverse,
}
