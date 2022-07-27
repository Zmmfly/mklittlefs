target("mklittlefs")
    set_kind("binary")
    set_targetdir("dist")
    add_defines("LFS_NAME_MAX=255")
    add_syslinks("pthread")
    add_ldflags("-static")

    add_files("main.cpp", "littlefs/*.c")
    add_includedirs(".", "include", "littlefs")

    before_build(function(target)
        outdata = os.iorun("git describe --always")
        outdata = string.gsub(outdata, "\r", "")
        outdata = string.gsub(outdata, "\n", "")
        outdata = "VERSION=\""..outdata.."\""
        print(outdata)
        target:add("defines", outdata)

        outdata = os.iorun("git -C littlefs describe --tags")
        outdata = string.gsub(outdata, "\r", "")
        outdata = string.gsub(outdata, "\n", "")
        outdata = "LITTLEFS_VERSION=\""..outdata.."\""
        print(outdata)
        target:add("defines", outdata)
    end)
