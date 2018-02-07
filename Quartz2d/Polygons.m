//
//  Polygons.m
//  Quartz2d
//
//  Created by Hassan Ahmed on 07/02/2018.
//  Copyright © 2018 Hassan Ahmed. All rights reserved.
//

#import "Polygons.h"

@implementation Polygons

- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
    
    // Drawing code here.
    CGContextRef context = [NSGraphicsContext currentContext].graphicsPort;
    CGContextTranslateCTM(context, 100.0, 100.0);
//    [self doPolygons:context];
    [self doPolygonsByArcs:context];
}

- (void)doPolygons:(CGContextRef)context {
    CGFloat sides = 5;
    CGRect rect = {{100.0, 100.0}, {100.0, 100.0}};
    
    CGFloat radius = floorf( 0.9 * MIN(rect.size.width, rect.size.height) / 2.0f );
    
    CGContextSetRGBFillColor(context, 1.0, 0.0, 0.0, 1.0);
    CGContextSetRGBStrokeColor(context, 0.0, 1.0, 0.0, 1.0);
    CGContextSetLineWidth(context, 6.0);
    CGContextSetLineCap(context, kCGLineCapRound);
    
    CGMutablePathRef path = CGPathCreateMutable();
//    CGFloat startingAngle = M_PI_2;
    for (int n = 0; n < sides; n++) {
        CGFloat rotationFactor = ((2 * M_PI) / sides) * (n+1) /*+ startingAngle*/;
        CGFloat x = /*(rect.size.width / 2.0f) +*/ cos(rotationFactor) * radius;
        CGFloat y = /*(rect.size.height / 2.0f) +*/ sin(rotationFactor) * radius;
        
        if (n == 0) {
            CGPathMoveToPoint(path, NULL, x, y);
        } else {
            CGPathAddLineToPoint(path, NULL, x, y);
        }
    }
    CGPathCloseSubpath(path);
    CGContextAddPath(context, path);
    CGContextDrawPath(context, kCGPathFillStroke);
    
    CFRelease(path);
}

- (void)doPolygonsByArcs:(CGContextRef)context {
    // Set fill color.
    CGContextSetRGBFillColor(context, 1.0, 0.0, 0.0, 1.0);
    // Set stroke color.
    CGContextSetRGBStrokeColor(context, 0.0, 1.0, 0.0, 1.0);
    // Set line width.
    CGContextSetLineWidth(context, 3.0);
    
    // Define transform variable and set it to identity.
    CGAffineTransform transform = CGAffineTransformIdentity;
    // Initialize variable for circle path.
    CGMutablePathRef circlePath = CGPathCreateMutable();
    // Initialize variable for polygon path.
    CGMutablePathRef polygonPath = CGPathCreateMutable();
    
    CGFloat sides = 8.0;
    // Angle between two adjacent sides of a polygon.
    CGFloat angle = 2*M_PI/sides;
    
    for (int i = 0; i < sides; i++) {
        // If its the first iteration
        if (i == 0) {
            // Move circular path to point zero.
            CGPathMoveToPoint(circlePath, NULL, 0.0, 0.0);
            // Add arc to the path
            CGPathAddArc(circlePath, NULL, 0.0, 0.0, 50.0, 0.0, angle, 0);
            // Retieve current point of the circle path.
            CGPoint p = CGPathGetCurrentPoint(circlePath);
            // Move polygon to the current point of circle path.
            CGPathMoveToPoint(polygonPath, NULL, p.x, p.y);
            // Initialize the rotation matrix with given angle.
            transform = CGAffineTransformMakeRotation(angle);
        }
        else {
            // Add arc to point.
            CGPathAddArc(circlePath, &transform, 0.0, 0.0, 50.0, 0.0, angle, 0);
            // Retreive current point of the circle path.
            CGPoint p = CGPathGetCurrentPoint(circlePath);
            // Add line to current point in polygon path.
            CGPathAddLineToPoint(polygonPath, NULL, p.x, p.y);
            // Rotate the transform matrix by given angle.
            transform = CGAffineTransformRotate(transform, angle);
        }
    }
    
    // Close circle path.
    CGPathCloseSubpath(circlePath);
    // Close polygon path.
    CGPathCloseSubpath(polygonPath);
    
    // Add circle path to context.
    CGContextAddPath(context, circlePath);
    // Stroke the path.
    CGContextStrokePath(context);
    
    // Add polygon path to context.
    CGContextAddPath(context, polygonPath);
    // Fill and stroke the path.
    CGContextDrawPath(context, kCGPathFillStroke);
    
    // Release created paths.
    CFRelease(circlePath);
    CFRelease(polygonPath);
}

@end
