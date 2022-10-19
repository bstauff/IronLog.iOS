device=$(xcrun xctrace list devices 2>&1 | grep -oE 'iPhone.*?[^\(]+' | head -1 | awk '{$1=$1;print}' | sed -e "s/ Simulator$//")

if [ $scheme = default ]; then
    scheme=$(cat default)
fi

if [ "$(ls -A | grep -i \.xcworkspace$)" ]; then
    filetype_parameter="workspace" && file_to_build="$(ls -A | grep -i \.xcworkspace$)"
else
    filetype_parameter="project" && file_to_build="$(ls -A | grep -i \.xcodeproj$)"
fi

file_to_build=$(echo $file_to_build | awk '{$1=$1;print}')

xcodebuild build-for-testing -scheme "Ironlog" -"$filetype_parameter" "$file_to_build" -destination "platform=$platform,name=$device"
