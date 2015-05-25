echo "testing installation"
dpkg -i $DEB
echo "testing correct version present after install"
[ $VERSION = $(java -version 2>&1 | head -n1 | cut -d ' ' -f 3 | tr -d '"') ]
echo "testing removal"
dpkg -r $PACKAGE
echo "testing no java available after removal"
[ -z $(which java) ]
