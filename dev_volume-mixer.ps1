# windows has an audio session on each playback audio device called "Idle"
#   whether or not the device is the default one
#   whether or not the session appears as an application in the gui
# weird, it's like arrays do start at zero, but windows reserves index one in the Sessions array ... sometimes
#   AudioDevice.Device.AudioSessionManager.Sessions[0] -> first 3rd party app to open an audio session on the device
#   AudioDevice.Device.AudioSessionManager.Sessions[1] -> Windows
#   AudioDevice.Device.AudioSessionManager.Sessions[2] -> second 3rd party app to open an audio session on the device
# MasterVolume of an audio session is in relation to MasterVolumeLevelScalar of parent audio device
################################################################################
# Index of playback device to check
$deviceIndex=1
########################
# Set $i to zero
$i=0

# While $i is less than the amount of audio session on the audio device
while($i -lt (Get-AudioDevice -Index $deviceIndex).Device.AudioSessionManager.Sessions.Count)
{
    Write-Host "########################"
    
    # Display audio session number
    Write-Host "Audio session #$($i + 1)"
    
    # Display processID of audio session
    Write-Host "Process name: $((Get-Process -Id (Get-AudioDevice -Index $deviceIndex).Device.AudioSessionManager.Sessions[$i].ProcessID).ProcessName)"

    # Display volume level of audio session
    Write-Host "Volume level: $(((Get-AudioDevice -Index $deviceIndex).Device.AudioSessionManager.Sessions[$i].SimpleAudioVolume.MasterVolume * 100).ToString('#'))%"

    # Display mute state of audio session
    Write-Host "Mute state:   $((Get-AudioDevice -Index $deviceIndex).Device.AudioSessionManager.Sessions[$i].SimpleAudioVolume.Mute)"

    # Increment $i
    $i++
}
Write-Host "########################"
 
