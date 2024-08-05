# List all folders in the /mnt/dev directory


folders="[]"

for dir in /mnt/dev/*; do
  if [ -d $dir ]; then 
    basename=$(basename $dir)

    folders=$(jq --arg name "$basename" --arg path "$dir" '. + [{name: $name, path: $path}]' <<< "$folders")
  fi;
done

echo $1

for extra_dir in $(jq -r '.[]' <<< "$1"); do
  if [ -d "$extra_dir" ]; then 
    basename=$(basename "$extra_dir")
    folders=$(jq --arg name "$basename" --arg path "$extra_dir" '. + [{name: $name, path: $path}]' <<< "$folders")
  fi
done

jq -n --argjson folders "$folders" '{folders: $folders}'
