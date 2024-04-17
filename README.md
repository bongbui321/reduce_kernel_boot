# Reduce kernel boot time
- List of optimization and profiling tools: https://elinux.org/Boot_Time#Kernel_speedups

## Inside boot.img
1. Kernel: The kernel is the core of the Android operating system. It manages the device's hardware resources, memory allocation, process management, and other low-level tasks. The kernel is typically based on the Linux kernel, with additional Android-specific modifications.

2. Ramdisk: The ramdisk is a small filesystem that is loaded into memory during the boot process. It contains essential files and directories required for the initial boot process, such as:

 - init binary: The first process that runs during boot and is responsible for initializing the Android system.
 - init.rc: The main configuration file for the init process, which defines the system services, their start order, and other boot-related settings.
 - fstab: The file system table that specifies the partitions and their mount points.
 - Default kernel modules and device tree blobs (DTBs) needed for booting the device.

The boot.img is created during the Android build process by combining the compiled kernel and the ramdisk into a single file. When an Android device boots, the bootloader loads the boot.img into memory and starts executing the kernel, which then mounts the ramdisk and starts the init process to continue the boot sequence.

- mkbootimg: https://android.googlesource.com/platform/system/tools/mkbootimg/

## Commands to see kernel modules loaded
### dmesg command:
The dmesg command prints the kernel ring buffer, which contains messages generated by the kernel during the boot process.
You can run dmesg in the Android shell (adb shell or via a terminal app) to view the kernel messages.
Look for lines that mention "module init" or "module loaded" to see which modules are being loaded.
Example: dmesg | grep "module init"

### /proc/modules:
The /proc/modules file provides a list of currently loaded kernel modules.
You can access this file from the Android shell.
Run cat /proc/modules to see the list of loaded modules along with their details, such as size, usage count, and dependencies.

### systool:
The systool is a command-line utility that provides information about the kernel modules and their parameters.
You may need to install the busybox package on your Android device to use this command.
Run systool -v -m to display a list of loaded modules with detailed information.
Kernel log:
The kernel log contains messages related to the loading and unloading of kernel modules.
You can access the kernel log using the logcat command in the Android shell.
Run logcat -d -b kernel to view the kernel log and look for messages related to module loading.
Init scripts or device tree:
Some Android devices may have init scripts (e.g., init.rc) or device tree configurations that specify which modules should be loaded during the boot process.
You can examine these files to determine which modules are being explicitly loaded.
The location and naming of these files may vary depending on the device and Android version.

## Progress:

- normal
```
```

- Kernel boot up time with `initcall_debug` (100 - 200ms more compared to normal)
```
------  -----  -----  ----
PON     1.5    1.5    10%
XBL     2.4    3.9    16%
ABL     3.7    7.6    25%
kernel  3.48   11.08  23%
weston  6.64   17.72  45%
comma   -2.87  14.85  -19%
onroad  ?      ?      -
------  -----  -----  ----

3.779s
3.644s
3.666s
3.655s
3.652s
3.605s
```

# Tested:
- No dynamic debug (No wifi) (link)[https://www.kernel.org/doc/html/v4.14/admin-guide/dynamic-debug-howto.html]
~- noop tracer~
~- lpj preset~ already set from calculating the timer frequency
~- no smp~ no speedup
 - no deferred_probe - more investigation. This takes a lot of time, not sure of what it does
 - no clk_debug (good) - saves 100ms
