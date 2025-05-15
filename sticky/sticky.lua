local micro = import("micro")
local config = import("micro/config")

local sticky = false

local function disableSticky(bp)
    if sticky then 
        bp:Deselect()
        sticky = false
    end
end

local function enableSticky(bp)
    if not sticky then sticky = true end
end

local function toggleSticky(bp)
    if sticky then
        disableSticky(bp)
    else
        enableSticky(bp)
    end
end

-- Use "$(stick.status)" on your statusformatl or statusformatr
-- Example : "statusformatl": "$(filename) $(modified)($(line),$(col)) $(status.paste)$(sticky.status)| ft:$(opt:filetype) | $(opt:fileformat) | $(opt:encoding)"
function status(b)
    return sticky and "STICKY " or ""
end

function init()
    micro.SetStatusInfoFn("sticky.status")
    config.MakeCommand('sticky', toggleSticky, config.NoComplete)
    config.TryBindKey("CtrlSpace", "command:sticky", true)
end

function onSelectAll()
    sticky = not sticky
end

function preCursorLeft(bp)
    if sticky then
        bp:SelectLeft()
        return false
    end
end

function preCursorRight(bp)
    if sticky then
        bp:SelectRight()
        return false
    end
end

function preCursorUp(bp)
    if sticky then
        bp:SelectUp()
        return false
    end
end

function preCursorDown(bp)
    if sticky then
        bp:SelectDown()
        return false
    end
end

function preWordRight(bp)
    if sticky then
        bp:SelectWordRight()
        return false
    end
end

function preWordLeft(bp)
    if sticky then
        bp:SelectWordLeft()
        return false
    end
end

function onCopy(bp)
    disableSticky(bp)
end

function onCut(bp)
    disableSticky(bp)
end

function preEscape(bp)
    disableSticky(bp)
end
