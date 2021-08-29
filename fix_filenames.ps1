$video_files = Get-ChildItem "C:\Users\Link\Videos\Captures" | where {$_.extension -in ".mp4" };
$file = $video_files[0];
$name = $file.Name;
$filtered_name = "";
for ($index = 0; $index -lt $name.Length; $index++)
{
    $character = $name[$index];
    $regex = "\w|\.|-|_|\s";

    if ($character -match $regex)
    {
        $filtered_name += $character;
    }
}

