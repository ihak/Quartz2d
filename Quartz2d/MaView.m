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

    [self doDashedLines:context];
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

- (void)createRectPath:(CGContextRef) context rect:(CGRect) rect {
    // Create a path using the coordinates of the rect passed in.
    CGContextBeginPath(context);
    CGContextMoveToPoint(context, rect.origin.x, rect.origin.y);
    // ********** Segment 1 **********
    CGContextAddLineToPoint(context, rect.origin.x + rect.size.width, rect.origin.y);
    // ********** Segment 2 **********
    CGContextAddLineToPoint(context, rect.origin.x + rect.size.width, rect.origin.y + rect.size.height);
    // ********** Segment 3 **********
    CGContextAddLineToPoint(context, rect.origin.x, rect.origin.y + rect.size.height);
    // ********** Segment 4 created by closing the path **********
    CGContextClosePath(context);
}

- (void)doPathRects:(CGContextRef)context {
    CGRect ourRect = {{20.0, 220.0}, {130.0, 100.0}};
    
    // ***** Rectangle 1 *****
    // Create the rect path.
    [self createRectPath:context rect:ourRect];
    // Set the fill color to the light opaque blue
    CGContextSetRGBFillColor(context, 0.482, 0.62, 0.871, 1.0);
    // Fill the path
    CGContextDrawPath(context, kCGPathFill); // Clear the path
    
    // ***** Rectangle 2 *****
    CGContextTranslateCTM(context, 200.0, 0.0);
    CGContextSetRGBStrokeColor(context, 0.404, 0.808, 0.239, 1.0);
    [self createRectPath:context rect:ourRect];
    CGContextSetLineWidth(context, 10.0);
    CGContextDrawPath(context, kCGPathStroke);
    
    // ***** Rectangle 3 *****
    CGContextTranslateCTM(context, -200.0, -200.0);
    [self createRectPath:context rect:ourRect];
    CGContextDrawPath(context, kCGPathFillStroke);
    
    // ***** Rectangle 4 *****
    CGContextTranslateCTM(context, 200.0, 0.0);
    [self createRectPath:context rect:ourRect];
    CGContextDrawPath(context, kCGPathStroke); // clears the path
    [self createRectPath:context rect:ourRect]; // create the path again
    CGContextDrawPath(context, kCGPathFill);
}

- (void)doAlphaRects:(CGContextRef)context {
    CGRect ourRect = {{0.0, 0.0}, {130.0, 100}};
    
    CGContextTranslateCTM(context, 300.0, 300.0);
    
    int numRects = 6;
    float tintAdjust = 1.0/numRects;
    float tint = 1.0;
    float rotateAngle = 2 * M_PI / numRects;
    
    for (int i = 0; i < numRects; i++, tint -= tintAdjust) {
        CGContextSetRGBFillColor(context, tint, 0.0, 0.0, tint);
        CGContextFillRect(context, ourRect);
        CGContextRotateCTM(context, rotateAngle);
    }
}

- (void)drawStrokedLine:(CGContextRef) context start:(CGPoint)start end:(CGPoint)end {
    CGContextBeginPath(context);
    CGContextMoveToPoint(context, start.x, start.y);
    CGContextAddLineToPoint(context, end.x, end.y);
    CGContextDrawPath(context, kCGPathStroke);
}

- (void)doDashedLines:(CGContextRef) context {
    CGPoint start, end;
    start.x = 20.0; start.y = 270.0;
    CGFloat const lengths[] = { 12.0, 6.0, 5.0, 6.0, 5.0, 6.0 };
    end.x = 300.0; end.y = 270.0;
    
    // ***** Line 1 solid line *****
    CGContextSetLineWidth(context, 5.0);
    [self drawStrokedLine:context start:start end:end];
    // ***** Line 2 long dashes *****
    CGContextTranslateCTM(context, 0.0, -50.0);
    CGContextSetLineDash(context, 0.0, lengths, 2);
    [self drawStrokedLine:context start:start end:end];
    // ***** Line 3 long short pattern
    CGContextTranslateCTM(context, 0.0, -50.0);
    CGContextSetLineDash(context, 0.0, lengths, 4);
    [self drawStrokedLine:context start:start end:end];
    // ***** Line 4 long short short pattern *****
    CGContextTranslateCTM(context, 0.0, -50.0);
    CGContextSetLineDash(context, 0.0, lengths, 6);
    [self drawStrokedLine:context start:start end:end];
    // ***** Line 5 short short long pattern *****
    CGContextTranslateCTM(context, 0.0, -50.0);
    CGContextSetLineDash(context, 18.0, lengths, 6);
    [self drawStrokedLine:context start:start end:end];
    // ***** Line 6 solid line *****
    CGContextTranslateCTM(context, 0.0, -50.0);
    CGContextSetLineDash(context, 0, NULL, 0); // Reset dash to solid line.
    [self drawStrokedLine:context start:start end:end];
}

@end
