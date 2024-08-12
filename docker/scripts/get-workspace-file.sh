# List all folders in the /mnt/dev directory


baseWorkspace=${1:-'{}'}

folders="[]"

for dir in /mnt/dev/*; do
  if [ -d $dir ]; then 
    basename=$(basename $dir)

    echo "Adding $basename to workspace file"

    folders=$(jq --arg name "$basename" --arg path "$dir" '. + [{name: $name, path: $path}]' <<< "$folders")
  fi;
done

newJson=$(jq -n --argjson folders "$folders" '{folders: $folders}')

echo "Merging with base workspace"
newJson=$(jq -s '.[0] * .[1]' <<< "$baseWorkspace" <<< "$newJson")

echo "New workspace file content:"
echo $newJson

echo "$newJson" > ~/workspace.code-workspace