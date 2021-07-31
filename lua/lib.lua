
function MissingPacker()
    return not pcall(vim.cmd, 'packadd packer.nvim')
end

function InstallPacker()
    local cmd = vim.cmd
    local fn = vim.fn

    if fn.input("Install packer.nvim? (y for yada)") ~= "y" then
        return
    end

    local directory = string.format(
        '%s/site/pack/packer/opt/',
        fn.stdpath('data')
    )

    fn.mkdir(directory, 'p')

    local git_clone_cmd = fn.system(string.format(
        'git clone %s %s',
        'https://github.com/wbthomason/packer.nvim',
        directory .. '/packer.nvim'
    ))

    print(git_clone_cmd)
    print("Installing packer.nvim...")
end
