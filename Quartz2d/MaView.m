//
//  MaView.m
//  Quartz2d
//
//  Created by Hassan Ahmed on 18/01/2018.
//  Copyright © 2018 Hassan Ahmed. All rights reserved.
//

#import "MaView.h"

@implementation MaView

- (void)drawRect:(NSRect)dirtyRect {
    
    // Drawing code here.
    
    CGContextRef context = [[NSGraphicsContext currentContext] graphicsPort];
//    CGContextSetRGBFillColor(context, 1, 0, 0, 1);
//    CGContextFillRect(context, CGRectMake(0, 0, 200, 100));
//    CGContextSetRGBFillColor(context, 0, 0, 1, 0.5);
//    CGContextFillRect(context, CGRectMake(0, 0, 100, 200));

    [self doStrokeAndFillRect:context];
    [super drawRect:dirtyRect];
}

- (void)doSimpleRect:(CGContextRef) context {
    CGRect ourRect;
    
    // Setup the rectangle for drawing
    ourRect.origin.x = ourRect.origin.y = 20.0;
    ourRect.size.width = 130.0;
    ourRect.size.height = 100.0;
    
    // Draw the filled rectangle
    CGContextFillRect(context, ourRect);
}

- (void)doStrokedRect:(CGContextRef) context {
    CGRect ourRect;
    
    CGContextSetRGBStrokeColor(context, 0.482, 0.62, 0.871, 1.0);
    // Setup the rectangle for the drawing
    ourRect.origin.x = ourRect.origin.y = 20.0;
    ourRect.size.width = 130.0;
    ourRect.size.height = 100.0;
    
    CGContextStrokeRectWithWidth(context, ourRect, 3.0);
}

- (void)doStrokeAndFillRect:(CGContextRef) context {
    // Define a rectanlge to use for drawing
    CGRect ourRect = {{20.0, 220.0}, {130.0, 100.0}};
    
    // ********** Rectangle 1 **********
    // Set the fill color to the light opaque blue.
    CGContextSetRGBFillColor(context, 0.482, 0.62, 0.871, 1.0);
    // Set the stroke color to an opaque green.
    CGContextSetRGBStrokeColor(context, 0.404, 0.808, 0.239, 1.0);
    // Fill the rectangle
    CGContextFillRect(context, ourRect);
    
    // ********** Rectangle 2 **********
    // Move the rectangle’s origin to the right by 200 units.
    ourRect.origin.x += 200.0;
    // Stroke the rectangle with a line width of 10.0
    CGContextStrokeRectWithWidth(context, ourRect, 10.0);
    
    // ********** Rectangle 3 **********
    ourRect.origin.x -= 200.0;
    ourRect.origin.y -= 200.0;
    // Fill then stroke the rectangle with a line width of 10.0
    CGContextFillRect(context, ourRect);
    CGContextStrokeRectWithWidth(context, ourRect, 10.0);
    
    // ********** Rectangle 4 **********
    // Move the rectangle’s origin to the right by 200 units.
    ourRect.origin.x += 200.0;
    // Stroke then fill the rectangle.
    CGContextStrokeRectWithWidth(context, ourRect, 10.0);
    CGContextFillRect(context, ourRect);
}

@end
