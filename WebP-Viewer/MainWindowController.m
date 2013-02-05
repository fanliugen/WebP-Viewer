//
//  MainWindowController.m
//  WebP-Viewer
//
//  Created by Darcy on 2/5/13.
//  Copyright (c) 2013 Darcy Liu. All rights reserved.
//

#import "MainWindowController.h"

@interface MainWindowController ()

@end

@implementation MainWindowController

- (id)initWithWindow:(NSWindow *)window
{
    self = [super initWithWindow:window];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

- (void)windowDidLoad
{
    [super windowDidLoad];
    
    // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
}
// -------------------------------------------------------------------------------
//	window:willUseFullScreenContentSize:proposedSize
//
//  A window's delegate can optionally override this method, to specify a different
//  full screen size for the window. This delegate method override's the window's full
//  screen content size to include a border space around it.
// -------------------------------------------------------------------------------
- (NSSize)window:(NSWindow *)window willUseFullScreenContentSize:(NSSize)proposedSize
{
    // leave a border space around our full screen window
    //
    return NSMakeSize(proposedSize.width - 180, proposedSize.height - 100);
}

// -------------------------------------------------------------------------------
//	window:willUseFullScreenPresentationOptions:proposedOptions
//
//  Delegate method to determine the presentation options the window will use when
//  transitioning to full-screen mode.
// -------------------------------------------------------------------------------
- (NSApplicationPresentationOptions)window:(NSWindow *)window willUseFullScreenPresentationOptions:(NSApplicationPresentationOptions)proposedOptions
{
    // customize our appearance when entering full screen:
    // we don't want the dock to appear but we want the menubar to hide/show automatically
    //
    return (NSApplicationPresentationFullScreen |       // support full screen for this window (required)
            NSApplicationPresentationHideDock |         // completely hide the dock
            NSApplicationPresentationAutoHideMenuBar);  // yes we want the menu bar to show/hide
}
@end
