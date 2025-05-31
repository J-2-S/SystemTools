local async = api.load_async_tools()
local async_io = async.io
local fs = api.load_fs_tools()
local json = api.load_json_tools()

function RenameFile(oldname, newname)
   return os.rename(oldname, newname)
end

function CreateFile(name)
   if fs.exists(name) then
      return "File already exists"
   end
   local file = io.open(name, "w")
   if file then
      file:close()
      return "Created new file"
   else
      return "Failed to create file"
   end
end

function ReadFile(name)
   local file = async_io.open(name, "r")
   if file then
      return file:read()
   else
      return string.format("%s file does not exists", name);
   end
end

function WriteFile(name, content)
   local file = async_io.open(name, "w")
   if file then
      return file:write(content)
   else
      return "Failed to open file"
   end
end

function FindFile(start, name, count, found)
   count = count or 1
   found = found or {}

   if start:sub(-1) ~= "/" then
      start = start .. "/"
   end

   for _, item in ipairs(fs.list_dir(start)) do
      if #found >= count then
         break
      end

      local full_path = fs.join(start, item)

      if fs.is_dir(full_path) then
         FindFile(full_path, name, count, found)
      elseif fs.is_file(full_path) then
         if item == name then
            table.insert(found, full_path)
         end
      end

      async.sleep(0)
   end

   return found
end

function CreateDir(name)
   local status, msg = pcall(fs.create_dir, name)
   if status then
      return msg
   else
      return ("Created %s dir"):format(name)
   end
end

function CreatePath(name)
   local status, msg = pcall(fs.create_path, name)
   if status then
      return msg
   else
      return ("Created %s path"):format(name)
   end
end
