//
//  WebPImage.h
//  WebP-Viewer
//
//  Created by Darcy on 1/15/13.
//  Copyright (c) 2013 Darcy Liu. All rights reserved.
//
#import <Cocoa/Cocoa.h>
#import <Foundation/Foundation.h>

@interface WebPImage : NSObject

@property(nonatomic, readonly, copy) NSString *name;
@property(nonatomic, retain) NSImage *thumbImage;
@property(nonatomic, retain) NSImage *fullImage;

// This is the designated initializer.
// Returns nil if filePath is nil. If filePath points to an invalid file
// then no image will be loaded in fulImage and thumbImage.
- (id)initFromFile:(NSString *)filePath;

@end
