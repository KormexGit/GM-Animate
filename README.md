## GM Animate - Easily manage sprite animations in GameMaker
GM Animate is made to be beginner friendly, and uses a GameMaker-like function structure that makes it immediately familiar.

LTS compatible! Works on any GM version 2022.0 or newer.

## Features:
- Doesn't interfere with GM's built in animation, so you can use both at once if desired
- Play multiple sprite animations on one object
- Check if an animation has finished or is on a specified frame
- Animation queue to automatically play animations one after another
- Pause or unpause all animations in the game at once
- Effects with animation curves! Use an included curve or make your own
  - Squash and strech, alters image_xscale and image_yscale to make a sprite "bounce". 
  - Sway, makes a sprite rotate back and forth.
  - Oscillate, makes a sprite move up and down (or any direction you choose!)
  - Shake, like a screen shake, but just for one sprite.
  - Hitstop, stop an animation for a specified number of frames.
  - Blink, fades an animation in and out, like an old school invincibility frame effect.

## Adding GM Animate to your project
1. [Download the newest .yymps file here](https://github.com/KormexGit/GM-Animate/releases)
2. While your project is open, either drag the file in, or go to the tools menu at the top, hit import local package, and select the file
3. Click "add all" and then "import"
4. A folder called "GM Animate" should appear in your asset browser
5. You're all set! 

## Updating GM Animate to a new version

Select the GM Animate folder in your project, and delete it entirely. Then, follow the instructions above again to add the new version. 

## Guide and documentation links

Once you've got GM Animate added to your project, check out the [basics guide](https://github.com/KormexGit/GM-Animate/wiki/Basics-Guide) to learn how to use it!

You can also find full documentation on the [Github wiki page](https://github.com/KormexGit/GM-Animate/wiki).

A sample project is in the repo but is still WIP.


### Planned features for the future (at whatever point I get around to it)
- More effects!
- A curve runner: Changes a variable based on an animation curve. Would work with any variable, not just ones inside the GM animate system
- Attachment point editor (this one may take a while)
- Functions to automatically keep animations attached to eachother at the chosen points/angles

## More resources
Need help with GM Animate? Looking for more libraries and tools for GameMaker? Come join us at the [GameMaker Kitchen discord server](https://discord.gg/8krYCqr)! You can find the thread for GM Animate in the `your_resources` forum.
