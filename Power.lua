function Shutdown()
    if os.get_os_name() == "windows" then
        os.execute("shutdown /s /t 5")
    elseif api.get_os_name() == "linux" then
        os.execute("shutdown -P 1")
    elseif os.get_os_name() == "macos" then
        -- I think this how I have to test I don't own a mac
        os.execute("shutdown -h now")
    else
        print("unknow os can not shutdown")
    end
end

function Restart()
    if os.get_os_name() == "windows" then
        os.execute("shutdown /r /t 5")
    elseif os.get_os_name() == "linux" then
        os.execute("shutdown -r 1")
    elseif os.get_os_name() == "macos" then
        -- I think this how I have to test I don't own a mac
        os.execute("shutdown -r now")
    else
        print("unknow os can not restart")
    end
end
