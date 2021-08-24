# Spacing, since progressbar will cover info on new shell
for ($i = 0; $i -lt 6; $i++)
{
    Write-Host "Spacing for progress bar to not cover info..."
}

# READ CONFIG
Write-Host "Video converter starting up...";
$xmlFile = './config.xml';
[XML] $configXmlContent = Get-Content $xmlFile;
$ffmpeg = $configXmlContent.config.ffmpegpath;

Write-Host "Config successfully read! Getting video files...";
Write-Host "Converted videos will be stored in $($configXmlContent.config.outputpath)"
$video_files = Get-ChildItem $configXmlContent.config.inputpath | where {$_.extension -in ".mp4" }

Write-Host "$($video_files.count) video file/s found! starting converting...";

# START CONVERTING
for ($i = 0; $i -lt $video_files.count; $i++)
{
    # create/update progress bar
    $completage = $i / $video_files.count * 100;
    Write-Progress -Activity "Converting videos..." -Status "$completage% Complete" -PercentComplete $completage

    # prepare ffmpeg args
    $video_file = $video_files[$i]
    Write-Host "converting: " $video_file;
    $video_input_path = $video_file.FullName;
    $video_output_path = $configXmlContent.config.outputpath + $video_file.Name;
    # can't use beautiful concatenation here, because ffmpeg needs paths to be double quoted
    $ffmpeg_args = '-y -i "' + $video_input_path + '" -c:v libx265 -vtag hvc1 "' + $video_output_path + '"';
    # actually convert file
    Start-Process $ffmpeg -ArgumentList $ffmpeg_args -Wait -RedirectStandardOutput "process_output.txt" -RedirectStandardError "process_error.txt";
    # Delete video if enabled
    if ([int]$configXmlContent.config.deleteafterconvert)
    {
        Write-Host "Deleting original $($video_file)";
        Remove-Item -Path $video_file.FullName;
    }
}

Write-Host "Video converter has finished!"