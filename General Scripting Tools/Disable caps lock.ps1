$VK_CAPITAL = 0x14
$KEYEVENTF_KEYUP = 0x2

Add-Type @"
    using System;
    using System.Runtime.InteropServices;
    public class User32 {
        [DllImport("user32.dll")]
        public static extern void keybd_event(byte bVk, byte bScan, uint dwFlags, IntPtr dwExtraInfo);
    }
"@

$capsLockStatus = [Console]::CapsLock

if ($capsLockStatus) {
    # Simulate pressing the Caps Lock key
    [User32]::keybd_event($VK_CAPITAL, 0, 0, [IntPtr]::Zero)
    # Simulate releasing the Caps Lock key
    [User32]::keybd_event($VK_CAPITAL, 0, $KEYEVENTF_KEYUP, [IntPtr]::Zero)

    Write-Host "Caps Lock is now OFF."
} else {
    Write-Host "Caps Lock is already OFF."
}
