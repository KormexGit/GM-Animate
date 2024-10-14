//GM Animate version: 0.3.2


/// Automatic mode will run animations automatically, without needing to call animation_run() in the step event of each object.
/// However, automatic mode can have problems if your are deactivating and reactivating instances.
/// It can also potentially cause weirdness if you leave a room and return to it at the start of the game before the garbage collector has initialized.
/// I recommend having automatic mode set to false if you do any deactivation, or run into any other issues with automatic mode.
#macro ANIMATION_AUTOMATIC_MODE false