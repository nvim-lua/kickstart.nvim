-- Global objects
globals = {
    "vim",
    "assert",
    "after_each",
    "before_each",
    "describe",
    "it",
    "teardown",
    "pending",
}

-- Rerun tests only if their modification time changed
cache = true

-- Don't report unused self arguments of methods
self = false

-- Redefine these functions to support OpenResty AWS Lambda
read_globals = {
    "ngx",
    "jit",
    "require",
    "package",
    "string",
    "table",
    "math",
    "io",
    "os",
    "print",
    "tonumber",
    "tostring",
    "type",
    "select",
    "pairs",
    "ipairs",
    "next",
    "error",
    "pcall",
    "xpcall",
    "unpack",
}

-- Maximum line length
max_line_length = 120

-- Don't report unused arguments
unused_args = false

-- Don't check unreachable code
unreachable = false
