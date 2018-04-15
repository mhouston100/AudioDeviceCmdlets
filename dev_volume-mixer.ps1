# windows has an audio session on each playback audio device
#   whether or not the device is the default one
#   whether or not the session appears as an application in the gui
# weird, it's like arrays do start at zero, but windows reserves index one in the Sessions array
#   AudioDevice.Device.AudioSessionManager.Sessions[0] -> first 3rd party app to open an audio session on the device
#   AudioDevice.Device.AudioSessionManager.Sessions[1] -> Windows
#   AudioDevice.Device.AudioSessionManager.Sessions[2] -> second 3rd party app to open an audio session on the device
# MasterVolume of an audio session is in relation to MasterVolumeLevelScalar of parent audio device
################################################################################
$deviceIndex=2
########################


$i=0
# While $i is less than the amount of audio session on the audio device
while($i -lt (Get-AudioDevice -Index $deviceIndex).Device.AudioSessionManager.Sessions.Count)
{
    # Get processID of audio session
    Write-Host "App"
    (Get-Process -Id (Get-AudioDevice -Index $deviceIndex).Device.AudioSessionManager.Sessions[$i].ProcessID).ProcessName

    # Get volume level of audio session
    Write-Host "Volume"
    (Get-AudioDevice -Index $deviceIndex).Device.AudioSessionManager.Sessions[$i].SimpleAudioVolume.MasterVolume * 100

    # Get mute state of audio session
    Write-Host "Mute"
    (Get-AudioDevice -Index $deviceIndex).Device.AudioSessionManager.Sessions[$i].SimpleAudioVolume.Mute

    Write-Host "########################"

    # Increment $i
    $i++
}
 