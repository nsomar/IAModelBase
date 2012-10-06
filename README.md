IAAnimationTable
================

This project was a test to add a new animation type to inserting <code>UITableViewCell</code>
It is also a demo project that can be viewed as a swizzling and objc association methods


How does this work
================

A new type of animation is being added <code>UITableViewRowAnimationFromBottom</code>

In order to use this:

1. add an import
    <code>#import "UITableView+BottomAnimation.h"</code>

2. use the new animation type

    <code>[table insertRowsAtIndexPaths:additions
                 withRowAnimation:UITableViewRowAnimationFromBottom];</code>
                 

Now the newly added rows will have a nice animation added to them

Note: i didnt try to submit an application to the appstore, so am not sure if it will be accepted or not.