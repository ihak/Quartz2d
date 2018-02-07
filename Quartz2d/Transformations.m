//
//  Transformations.m
//  Quartz2d
//
//  Created by Hassan Ahmed on 22/01/2018.
//  Copyright © 2018 Hassan Ahmed. All rights reserved.
//

#import "Transformations.h"

@implementation Transformations

- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
    
    // Drawing code here.
    CGContextRef context = [NSGraphicsContext currentContext].graphicsPort;
    CGContextTranslateCTM(context, 50.0, 50.0);
//    [self drawCoordinateAxes:context ofLength:4];
    [self doRotatedEllipses:context];
}

- (void)drawCoordinateAxes:(CGContextRef)context ofLength:(int)length {
    CGFloat arrowHeadLength = 15.0;
    CGFloat arrowHeadWidth = 3.0;
    
    // Begin path
    CGContextBeginPath(context);
    // Set line width to 2.0
    CGContextSetLineWidth(context, 2.0);
    // Creating x-axis. 5 points behind the origin
    CGContextMoveToPoint(context, -5.0, 0.0);
    int i;
    for (i = 1; i <= length; i++) {
        CGContextAddLineToPoint(context, 72.0 * i, 0.0);
        CGContextMoveToPoint(context, 72.0 * i, arrowHeadWidth);
        CGContextAddLineToPoint(context, 72.0 * i, -arrowHeadWidth);
        CGContextMoveToPoint(context, 72.0 * i, 0.0);
    }
    // Draw path after adding line segments
    CGContextDrawPath(context, kCGPathStroke);
    
    // Add horizontal arrow head
    i--;
    CGContextMoveToPoint(context, 72.0 * i, 0.0);
    CGContextAddLineToPoint(context, 72.0 * i, -arrowHeadWidth);
    CGContextAddLineToPoint(context, 72.0 * i + arrowHeadLength, 0.0);
    CGContextAddLineToPoint(context, 72.0 * i, arrowHeadWidth);
    CGContextClosePath(context);
    CGContextDrawPath(context, kCGPathFill);
    
    // Create y-axis. 5 points below the origin.
    CGContextMoveToPoint(context, 0.0, -5.0);
    for (i = 1; i <= length; i++) {
        CGContextAddLineToPoint(context, 0.0, 72.0 * i);
        CGContextMoveToPoint(context, -arrowHeadWidth, 72.0 * i);
        CGContextAddLineToPoint(context, arrowHeadWidth, 72.0 * i);
        CGContextMoveToPoint(context, 0.0, 72.0 * i);
    }
    // Draw path after adding line segments
    CGContextDrawPath(context, kCGPathStroke);
    
    // Add vertical arrow head
    i--;
    CGContextMoveToPoint(context, 0.0, 72.0 * i);
    CGContextAddLineToPoint(context,  -arrowHeadWidth, 72.0 * i);
    CGContextAddLineToPoint(context, 0.0, 72.0 * i + arrowHeadLength);
    CGContextAddLineToPoint(context, arrowHeadWidth, 72.0 * i);
    CGContextClosePath(context);
    CGContextDrawPath(context, kCGPathFill);
}

- (void)doDefaultRect:(CGContextRef)context {
    [self drawCoordinateAxes:context ofLength:3];
    CGRect ourRect = {{0, 0}, {72.0, 72.0}};
    CGContextFillRect(context, ourRect);
    
//    [self doTranslationThenScale:context rect:ourRect];
//    [self doScaleThenTranslation:context rect:ourRect];
    [self doRotateThenScale:context rect:ourRect];
//    [self doScaleThenRotate:context rect:ourRect];
}

- (void)doScaleThenTranslation:(CGContextRef)context rect:(CGRect)rect {
    // Set fill and stroke colors
    CGContextSetRGBFillColor(context, 115.0/256.0, 158.0/256.0, 198.0/256.0, 1.0);
    CGContextSetRGBStrokeColor(context, 115.0/256.0, 158.0/256.0, 198.0/256.0, 1.0);
    
    // perform scale then translate
    CGContextScaleCTM(context, 2.0, 2.0);
    CGContextTranslateCTM(context, 72.0, 36.0);
    // fill rect
    CGContextFillRect(context, rect);
    
    // scale down ctm back to draw coordinates
    CGContextScaleCTM(context, 0.5, 0.5);
    // draw coordinates
    [self drawCoordinateAxes:context ofLength:3];
}

- (void)doTranslationThenScale:(CGContextRef)context rect:(CGRect)rect {
    // set fill and stroke colors
    CGContextSetRGBFillColor(context, 242.0/256.0, 201.0/256.0, 128.0/256.0, 1.0);
    CGContextSetRGBStrokeColor(context, 242.0/256.0, 201.0/256.0, 128.0/256.0, 1.0);
    
    // translate
    CGContextTranslateCTM(context, 72.0, 36.0);
    // draw coordinates
    [self drawCoordinateAxes:context ofLength:3];

    // scale
    CGContextScaleCTM(context, 2.0, 2.0);
    // fill rect
    CGContextFillRect(context, rect);
}

- (void)doScaleThenRotate:(CGContextRef)context rect:(CGRect)rect {
    // set fill color with transparency
    CGContextSetRGBFillColor(context, 228.0/256.0, 155.0/256.0, 62.0/256.0, 0.75);
    // perform scaling and rotation
    CGContextScaleCTM(context, 0.5, 2.0);
    CGContextRotateCTM(context, (M_PI/180.0)*30);
    CGContextFillRect(context, rect);
    
    CGContextSetRGBFillColor(context, 228.0/256.0, 155.0/256.0, 62.0/256.0, 1.0);
    CGContextSetRGBStrokeColor(context, 228.0/256.0, 155.0/256.0, 62.0/256.0, 1.0);
    CGContextScaleCTM(context, 1.0, 0.5);
    [self drawCoordinateAxes:context ofLength:3];
}

- (void)doRotateThenScale:(CGContextRef)context rect:(CGRect)rect {
    CGContextSetRGBFillColor(context, 160.0/256.0, 129.0/256.0, 163.0/256.0, 0.5);
    CGContextSetRGBStrokeColor(context, 160.0/256.0, 129.0/256.0, 163.0/256.0, 0.5);

    // save graphics context before performing transformations
    CGContextSaveGState(context);
    {
        // rotate then scale
        CGContextRotateCTM(context, (M_PI/180.0)*30);
        CGContextScaleCTM(context, 0.5, 2.0);
        // fill rect
        CGContextFillRect(context, rect);
    }
    CGContextRestoreGState(context);
    
    CGContextSaveGState(context);
    {
        // rotate
        CGContextRotateCTM(context, (M_PI/180.0)*30);
        // draw coordinate axises
        [self drawCoordinateAxes:context ofLength:3];
    }
    CGContextRestoreGState(context);
}

- (void)doSimpleEllipse:(CGContextRef)context {
    CGAffineTransform transform = CGAffineTransformMakeScale(2.0, 1.0);
    CGContextTranslateCTM(context, 100.0, 100.0);
    CGContextConcatCTM(context, transform);
    CGContextBeginPath(context);
    CGContextAddArc(context, 0.0, 0.0, 45.0, 0.0, 2*M_PI, 0);
    CGContextDrawPath(context, kCGPathFill);
}

- (void)doRotatedEllipses:(CGContextRef)context {
    int i = 0, totalReps = 144;
    float tint = 1.0, tintIncrement = 1.0/totalReps;
    // Create a new transform consisting of a 45 degree rotation.
    CGAffineTransform transform = CGAffineTransformMakeRotation(M_PI_4);
    // Apply a scale to the transform just created.
    transform = CGAffineTransformScale(transform, 1, 2);
    // Place the first ellipse at a good location
    CGContextTranslateCTM(context, 100.0, 100.0);
    
    for (i = 0; i < totalReps; i++) {
        // Make a snapshot of the coordinate system.
        CGContextSaveGState(context);
        {
            // Setup the coordinate system for the rotated ellipse.
            CGContextConcatCTM(context, transform);
            CGContextBeginPath(context);
            CGContextAddArc(context, 0.0, 0.0, 45.0, 0.0, 2*M_PI, 0);
            // Set the RGB fill color
            CGContextSetRGBFillColor(context, tint, 0.0, 0.0, 1.0);
            CGContextDrawPath(context, kCGPathFill);
        }
        // Restore the quardinate coordinate system to that of the snapshot.
        CGContextRestoreGState(context);
        // Compute the next tint color.
        tint -= tintIncrement;
        // Move over by 1 unit in x for the next ellipse.
        CGContextTranslateCTM(context, 1.0, 0.0);
    }
}

- (void)drawSkewedCoordinateSystem:(CGContextRef)context {
    float alpha = M_PI/8, beta = M_PI/12;
    CGAffineTransform skew;
    
    // Create a rectangle that is 72 units on a side
    // with its origin at (0,0).
    CGRect r = CGRectMake(0, 0, 72, 72);
    
    CGContextTranslateCTM(context, 144, 144);
    // Draw the coordinate axes untransformed.
    [self drawCoordinateAxes:context ofLength:3];
    // Fill the rectangle.
    CGContextFillRect(context, r);
    
    // Create an affine transform that skews the coordinate system,
    // skewing the x axis by alpha radians and the y axis by beta radians.
    skew = CGAffineTransformMake(1, tan(alpha), tan(beta), 1, 0, 0);
    // Apply that transform to the context coordinate system.
    CGContextConcatCTM(context, skew);
    // Set the fill and stroke color to a dark blue.
    CGContextSetRGBStrokeColor(context, 0.11, 0.208, 0.451, 1.0);
    CGContextSetRGBFillColor(context, 0.11, 0.208, 0.451, 1.0);
    // Draw the coordinate axes again, now transformed.
    [self drawCoordinateAxes:context ofLength:3];
    // Set the fill color again but with a partially transparent alpha.
    CGContextSetRGBFillColor(context, 0.11, 0.208, 0.451, 0.7);
    // Fill the rectangle in the transformed coordinate system.
    CGContextFillRect(context, r);
}

@end
