read -p 'm ' _path

if [ -d $_path ]; then
    echo 'y'
else
    echo 'n'
fi