#!/bin/bash
# install mongodb-compass
mkdirs() {
	if [[ "$HOME" == "$PWD" ]]; then
		mkdir -p "$HOME/sgoinfre/home_lh/$1"
		link_s $HOME/"$1" "$HOME/sgoinfre/home_lh/$1" &>/dev/null
	else
	mkdir "$@"
	fi
}

DIRINSTALL="$HOME/sgoinfre/app"
ICONE="$HOME/.local/share/icons"
DESK="$HOME/.local/share/applications"
URL="https://downloads.mongodb.com/compass/mongodb-compass_1.45.4_amd64.deb"
DEB_FILE="$DIRINSTALL/mongodb-compass.deb"
EXE="$HOME/sgoinfre/app/mongodb-compass/mongodb-compass"
EXTRACTED_DIR="$DIRINSTALL/mongodb-compass"
ICME="$HOME/sgoinfre/app/mongodb-compass/usr/share/pixmaps/mongodb-compass.png"

mkdir -p "$DIRINSTALL" "$ICONE" "$DESK"

echo "Baixando MongoDB Compass..."
wget -O "$DEB_FILE" "$URL"

mkdir -p "$EXTRACTED_DIR"
dpkg-deb -x "$DEB_FILE" "$EXTRACTED_DIR"

ln -sf "$EXTRACTED_DIR/usr/bin/mongodb-compass" "$DIRINSTALL/mongodb-compass"

cd $HOME

mkdirs ".mongodb"

cat > "$DESK/mongodb-compass.desktop" <<EOF
[Desktop Entry]
Name=MongoDB Compass
Comment=The MongoDB GUI
GenericName=MongoDB Compass
Exec=$EXE %U
Icon=$ICME
Type=Application
StartupNotify=true
Categories=GNOME;GTK;Utility;
MimeType=x-scheme-handler/mongodb;x-scheme-handler/mongodb+srv;
EOF

cp "$ICME" "$ICONE/mongodb-compass.png"

echo "MongoDB Compass instalado em $DIRINSTALL"
echo "Para executar, use: $DIRINSTALL/mongodb-compass"
