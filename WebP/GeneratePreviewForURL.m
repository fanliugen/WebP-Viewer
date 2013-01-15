#include <CoreFoundation/CoreFoundation.h>
#include <CoreServices/CoreServices.h>
#include <QuickLook/QuickLook.h>
#import <Cocoa/Cocoa.h>
#import "WebPImage.h"

OSStatus GeneratePreviewForURL(void *thisInterface, QLPreviewRequestRef preview, CFURLRef url, CFStringRef contentTypeUTI, CFDictionaryRef options);
void CancelPreviewGeneration(void *thisInterface, QLPreviewRequestRef preview);

/* -----------------------------------------------------------------------------
   Generate a preview for file

   This function's job is to create preview for designated file
   ----------------------------------------------------------------------------- */

OSStatus GeneratePreviewForURL(void *thisInterface, QLPreviewRequestRef preview, CFURLRef url, CFStringRef contentTypeUTI, CFDictionaryRef options)
{
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
    NSURL *imgurl = (NSURL*)url;
    WebPImage* image = [[[WebPImage alloc] initFromFile:[imgurl path]] autorelease];
    NSImage *previewImage = image.fullImage;

    CGContextRef context = QLPreviewRequestCreateContext(preview, CGSizeMake([previewImage size].width, [previewImage size].height), true, NULL);
    NSGraphicsContext *gc = [NSGraphicsContext graphicsContextWithGraphicsPort:context flipped:NO];
    [NSGraphicsContext saveGraphicsState];
    [NSGraphicsContext setCurrentContext:gc];
    [previewImage drawInRect:NSMakeRect(0, 0, [previewImage size].width, [previewImage size].height) fromRect:NSZeroRect operation:NSCompositeSourceOver fraction:1.0];
    [NSGraphicsContext restoreGraphicsState];
    QLPreviewRequestFlushContext(preview, context);
    CFRelease(context);
    [pool release];
    return noErr;
}

void CancelPreviewGeneration(void *thisInterface, QLPreviewRequestRef preview)
{
    // Implement only if supported
}
