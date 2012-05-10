from fabric.api import run
from fabric.contrib import files
from fabric import operations, utils
from ConfigParser import RawConfigParser as ConfParser
from ConfigParser import Error

def change_ini_value(filePath, section, option, value):
    if not files.exists(filePath):
        return 1
    local = operations.get(filePath)
    p = ConfParser()
    for localFilePath in local:
        utils.puts("editing %s" % localFilePath)
        try:
            config = p.read(localFilePath)
            if not p.has_section(section):
                utils.puts("adding section %s" % section)
                p.add_section(section)
            p.set(section, option, value)
            with open(localFilePath, 'w') as f:
                p.write(f)
        except Error, msg:
            utils.puts("Error Parsing File")
            utils.puts(msg)
            return 1
        operations.put(localFilePath, filePath, use_sudo=True)

