//
//  CLAppDelegate.m
//  WebP-Viewer
//
//  Created by Darcy on 1/15/13.
//  Copyright (c) 2013 Darcy Liu. All rights reserved.
//

#import "CLAppDelegate.h"
#import "WebPImage.h"
@implementation CLAppDelegate

- (void)dealloc
{
    [super dealloc];
}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    // Insert code here to initialize your application
    // NSLog(@"applicationDidFinishLaunching: %@",aNotification);
//    NSImage *previewImage = [[[NSImage alloc] initWithContentsOfFile:@"/Users/Darcy/Downloads/hello.jpg"] autorelease];
//    NSLog(@"previewImage: %@",previewImage);
//    self.imageView.image = previewImage;
}

- (void)applicationDidBecomeActive:(NSNotification *)aNotification{
    // NSLog(@"applicationDidBecomeActive");
}

- (BOOL)applicationShouldHandleReopen:(NSApplication *)sender hasVisibleWindows:(BOOL)flag{
    // NSLog(@"applicationShouldHandleReopen:%d",flag);
    [self.window makeKeyAndOrderFront:nil];
    return YES;
}

- (BOOL)application:(NSApplication *)sender openFile:(NSString *)filename{
    // NSLog(@"filename: %@",filename);
    
    WebPImage* image = [[[WebPImage alloc] initFromFile:filename] autorelease];
    // NSLog(@"image: %@",image.fullImage);
    self.imageView.image = image.fullImage;
    [self.window makeKeyAndOrderFront:nil];
    return YES;
}

@end
