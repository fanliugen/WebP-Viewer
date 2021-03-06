//
//  WebPImage.m
//  WebP-Viewer
//
//  Created by Darcy on 1/15/13.
//  Copyright (c) 2013 Darcy Liu. All rights reserved.
//

#import "WebPImage.h"
#import "include/webp/decode.h"

static const int kWPUseThreads = 1;
static const int kThumbWidth = 40;
static const int kThumbHeight = 40;

// Callback for CGDataProviderRelease
static void FreeImageData(void *info, const void *data, size_t size) {
    free((void*)data);
}

@interface WebPImage ()

@property(nonatomic, copy) NSString *filePath;
@property(nonatomic, copy) NSString *name;

@end

@implementation WebPImage
@synthesize filePath = filePath_;
@synthesize name = name_;
@synthesize thumbImage = thumbImage_;
@synthesize fullImage = fullImage_;

- (id)init {
    return [self initFromFile:nil];
}

- (id)initFromFile:(NSString *)filePath{
    if ((self = [super init])) {
        if (filePath) {
            self.filePath = filePath;
            self.name =
            [[self.filePath componentsSeparatedByString:@"/"] lastObject];
        } else {
            [self release];
            self = nil;
        }
    }
    return self;
}

- (void)dealloc {
    [filePath_ release];
    [name_ release];
    [thumbImage_ release];
    [fullImage_ release];
    [super dealloc];
}

+ (NSImage *)loadWebPFromFile:(NSString *)filePath {
    WebPDecoderConfig config;
    if (!WebPInitDecoderConfig(&config)) {
        return nil;
    }
    
    config.output.colorspace = MODE_rgbA;
    config.options.use_threads = kWPUseThreads;
    
    return [WebPImage decodeWebPFromFile:filePath withConfig:&config];
}

+ (NSImage *)decodeWebPFromFile:(NSString *)filePath
                     withConfig:(WebPDecoderConfig *)config {
    NSData *myData = [NSData dataWithContentsOfFile:filePath];
    // Decode the WebP image data into a RGBA value array.
    if (WebPDecode([myData bytes], [myData length], config) != VP8_STATUS_OK) {
        return nil;
    }
    
    int width = config->input.width;
    int height = config->input.height;
    if (config->options.use_scaling) {
        width = config->options.scaled_width;
        height = config->options.scaled_height;
    }
    
    // Construct a UIImage from the decoded RGBA value array.
    CGDataProviderRef provider =
    CGDataProviderCreateWithData(NULL, config->output.u.RGBA.rgba,
                                 config->output.u.RGBA.size, FreeImageData);
    CGColorSpaceRef colorSpaceRef = CGColorSpaceCreateDeviceRGB();
    CGBitmapInfo bitmapInfo = kCGBitmapByteOrder32Big | kCGImageAlphaPremultipliedLast;
    CGColorRenderingIntent renderingIntent = kCGRenderingIntentDefault;
    CGImageRef imageRef =
    CGImageCreate(width, height, 8, 32, 4 * width, colorSpaceRef, bitmapInfo,
                  provider, NULL, NO, renderingIntent);
    
    CGColorSpaceRelease(colorSpaceRef);
    CGDataProviderRelease(provider);
    
    NSRect imageRect = NSMakeRect(0.0, 0.0, 0.0, 0.0);
    imageRect.size.height = CGImageGetHeight(imageRef);
    imageRect.size.width = CGImageGetWidth(imageRef);
    
    NSImage *newImage = [[[NSImage alloc] initWithCGImage:imageRef size:imageRect.size] autorelease];
    CGImageRelease(imageRef);
    
    return newImage;
}

// Decodes a resized WebP image specified by scaleWidth and scaleHeight.
// If scaledWidth and scaledHeight are smaller than the acutal width and height
// then this method directly decodes a smaller image. In that case this
// method saves some CPU and meomory resources as it decodes a smaller image.
+ (NSImage *)loadWebPFromFile:(NSString *)filePath
                  scaledWidth:(int)scaledWidth
                 scaledHeight:(int)scaledHeight {
    WebPDecoderConfig config;
    if (!WebPInitDecoderConfig(&config)) {
        return nil;
    }
    
    config.output.colorspace = MODE_rgbA;
    config.options.use_threads = kWPUseThreads;
    
    config.options.use_scaling = 1;
    config.options.scaled_width = scaledWidth;
    config.options.scaled_height = scaledHeight;
    
    return [WebPImage decodeWebPFromFile:filePath withConfig:&config];
}

- (NSImage *)thumbImage {
    @synchronized(self) {
        if (!thumbImage_) {
            thumbImage_ = [[WebPImage loadWebPFromFile:self.filePath
                                           scaledWidth:kThumbWidth
                                          scaledHeight:kThumbHeight] retain];
        }
    }
    return thumbImage_;
}

- (NSImage *)fullImage {
    @synchronized(self) {
        if (!fullImage_) {
            fullImage_ = [[WebPImage loadWebPFromFile:self.filePath] retain];
        }
    }
    return fullImage_;
}
@end
