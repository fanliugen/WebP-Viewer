#include <CoreFoundation/CoreFoundation.h>
#include <CoreServices/CoreServices.h>
#include <QuickLook/QuickLook.h>
#import <Cocoa/Cocoa.h>
OSStatus GenerateThumbnailForURL(void *thisInterface, QLThumbnailRequestRef thumbnail, CFURLRef url, CFStringRef contentTypeUTI, CFDictionaryRef options, CGSize maxSize);
void CancelThumbnailGeneration(void *thisInterface, QLThumbnailRequestRef thumbnail);

/* -----------------------------------------------------------------------------
    Generate a thumbnail for file

   This function's job is to create thumbnail for designated file as fast as possible
   ----------------------------------------------------------------------------- */

OSStatus GenerateThumbnailForURL(void *thisInterface, QLThumbnailRequestRef thumbnail, CFURLRef url, CFStringRef contentTypeUTI, CFDictionaryRef options, CGSize maxSize)
{
    // To complete your generator please implement the function GenerateThumbnailForURL in GenerateThumbnailForURL.c
    //NSLog(@"GenerateThumbnailForURL");
    //NSImage *previewImage = [[NSImage alloc] initWithContentsOfFile:@"/Users/Darcy/Downloads/hello.jpg"];
    //NSData *resizedData = [previewImage TIFFRepresentation];
    //QLThumbnailRequestSetImageWithData(thumbnail, (CFDataRef)resizedData, NULL);
    return noErr;
}

void CancelThumbnailGeneration(void *thisInterface, QLThumbnailRequestRef thumbnail)
{
    // Implement only if supported
}
