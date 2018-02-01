//
//  CubicBezierCurves.m
//  Quartz2d
//
//  Created by Hassan Ahmed Khan on 1/30/18.
//  Copyright © 2018 Hassan Ahmed. All rights reserved.
//

#import "CubicBezierCurves.h"

@implementation CubicBezierCurves

- (void)drawRect:(NSRect)dirtyRect {
    
    // Drawing code here.
    
    CGContextRef context = [[NSGraphicsContext currentContext] graphicsPort];
    CGContextTranslateCTM(context, 50.0, 50.0);

    //    CGContextSetRGBFillColor(context, 1, 0, 0, 1);
    //    CGContextFillRect(context, CGRectMake(0, 0, 200, 100));
    //    CGContextSetRGBFillColor(context, 0, 0, 1, 0.5);
    //    CGContextFillRect(context, CGRectMake(0, 0, 100, 200));
    
    [self doMovingArches:context];
    [super drawRect:dirtyRect];
}

- (void)doEgg:(CGContextRef)context {
    CGPoint p0 = {0.0, 0.0}, p1 = {0.0, 200.0};
    CGPoint c1 = {140.0, 5.0}, c2 = {80.0, 198.0};
    CGContextTranslateCTM(context, 100.0, 5.0);
    CGContextBeginPath(context);
    
    CGContextMoveToPoint(context, p0.x, p0.y);
    // Create the bezier path segment for the right side of the egg.
    CGContextAddCurveToPoint(context, c1.x, c1.y, c2.x, c2.y, p1.x, p1.y);
    // Create the bezier path segment for the left side of the egg.
    CGContextAddCurveToPoint(context, -c2.x, c2.y, -c1.x, c1.y, p0.x, p0.y);
    CGContextClosePath(context);
    CGContextSetLineWidth(context, 2.0);
    CGContextDrawPath(context, kCGPathStroke);
}

- (void)doMovingArches:(CGContextRef) context {
    CGPoint p0 = {0.0, 0.0}, p1 = {200.0, 0.0};
    CGPoint c1 = {0.0, 300.0}, c2 = {200.0, 300.0};
    CGContextTranslateCTM(context, 100.0, 5.0);
    
    [self createBoundingRect:context p0:p0 p1:p1 c1:c1 c2:c2];
    
    CGContextSetLineWidth(context, 2);
    CGContextSetRGBStrokeColor(context, 0.0, 0.0, 0.0, 1.0);
    do {
        [self drawTangents:context p0:p0 p1:p1 c1:c1 c2:c2];
        
        CGContextBeginPath(context);
        CGContextMoveToPoint(context, p0.x, p0.y);
        
        // Create the Bezier path segment
        CGContextAddCurveToPoint(context, c1.x, c1.y, c2.x, c2.y, p1.x, p1.y);
        
        CGContextDrawPath(context, kCGPathStroke);
        c1.x += 10;
        c2.x -= 10;
    } while (c1.x != c2.x);
}

- (void)doNegativeMovingArches:(CGContextRef) context {
    CGPoint p0 = {0.0, 0.0}, p1 = {200.0, 0.0};
    CGPoint c1 = {200.0, 300.0}, c2 = {0.0, 300.0};
    CGContextTranslateCTM(context, 100.0, 5.0);
    
    [self createBoundingRect:context p0:p0 p1:p1 c1:c1 c2:c2];
    
    CGContextSetLineWidth(context, 2);
    CGContextSetRGBStrokeColor(context, 0.0, 0.0, 0.0, 1.0);
    int i = 0;
    do {
        [self drawTangents:context p0:p0 p1:p1 c1:c1 c2:c2];
        CGContextBeginPath(context);
        CGContextMoveToPoint(context, p0.x, p0.y);
        
        // Create the Bezier path segment
        CGContextAddCurveToPoint(context, c1.x, c1.y, c2.x, c2.y, p1.x, p1.y);
        
        CGContextDrawPath(context, kCGPathStroke);
        c1.x += 10;
        c2.x -= 10;
        i++;
    } while (i < 10);
}

- (void)doArch:(CGContextRef)context {
    CGPoint p0 = {0.0, 0.0}, p1 = {200.0, 0.0};
    CGPoint c1 = {0.0, 300.0}, c2 = {200.0, 300.0};
    CGContextTranslateCTM(context, 100.0, 5.0);
    
    [self createBoundingRect:context p0:p0 p1:p1 c1:c1 c2:c2];
    [self drawTangents:context p0:p0 p1:p1 c1:c1 c2:c2];
    
    CGContextSetLineWidth(context, 2);
    CGContextSetRGBStrokeColor(context, 0.0, 0.0, 0.0, 1.0);
    CGContextBeginPath(context);
    CGContextMoveToPoint(context, p0.x, p0.y);
    
    // Create the Bezier path segment
    CGContextAddCurveToPoint(context, c1.x, c1.y, c2.x, c2.y, p1.x, p1.y);
    CGContextDrawPath(context, kCGPathStroke);
}

- (void)doWave:(CGContextRef)context {
    CGPoint p0 = {0.0, 0.0}, p1 = {200.0, 0.0};
    CGPoint c1 = {50.0, 50.0}, c2 = {150.0, -50.0};
    
    [self createBoundingRect:context p0:p0 p1:p1 c1:c1 c2:c2];
    [self drawTangents:context p0:p0 p1:p1 c1:c1 c2:c2];
    
    CGContextSetLineWidth(context, 2);
    CGContextSetRGBStrokeColor(context, 0.0, 0.0, 0.0, 1.0);
    CGContextBeginPath(context);
    CGContextMoveToPoint(context, p0.x, p0.y);
    
    // Create the Bezier path segment
    CGContextAddCurveToPoint(context, c1.x, c1.y, c2.x, c2.y, p1.x, p1.y);
    CGContextDrawPath(context, kCGPathStroke);
}

- (void)createBoundingRect:(CGContextRef)context p0:(CGPoint)p0 p1:(CGPoint)p1 c1:(CGPoint)c1 c2:(CGPoint)c2 {
    CGContextSetLineWidth(context, 1);
    CGContextSetRGBStrokeColor(context, 1.0, 0.0, 0.0, 1.0);
    
    CGContextBeginPath(context);
    CGContextMoveToPoint(context, p0.x, p0.y);
    CGContextAddLineToPoint(context, c1.x, c1.y);
    CGContextAddLineToPoint(context, c2.x, c2.y);
    CGContextAddLineToPoint(context, p1.x, p1.y);
    CGContextClosePath(context);
    
    CGContextDrawPath(context, kCGPathStroke);
}

- (void)drawTangents:(CGContextRef)context p0:(CGPoint)p0 p1:(CGPoint)p1 c1:(CGPoint)c1 c2:(CGPoint)c2 {
    CGContextSaveGState(context);
    
    CGContextBeginPath(context);
    // Add tangents
    CGContextSetLineWidth(context, 1.0);
    CGContextSetRGBStrokeColor(context, 0.0, 1.0, 0.0, 1.0);
    CGContextMoveToPoint(context, p0.x, p0.y);
    CGContextAddLineToPoint(context, c1.x, c1.y);
    
    CGContextMoveToPoint(context, p1.x, p1.y);
    CGContextAddLineToPoint(context, c2.x, c2.y);
    CGContextStrokePath(context);
    
    CGContextRestoreGState(context);
}

- (void)addRoundedRectToPath:(CGContextRef) context rect:(CGRect)rect ovalWidth:(CGFloat)ovalWidth ovalHeight:(CGFloat)ovalHeight {
    float fw, fh;
    // If either ovalWidth or ovalHeight is zero, add a regular rectangle.
    if (ovalWidth == 0 || ovalHeight == 0) {
        CGContextAddRect(context, rect);
    }
    else {
        CGContextSaveGState(context);
        {
            // Translate to lower-left corner of rectangle
            CGContextTranslateCTM(context, CGRectGetMinX(rect), CGRectGetMinY(rect));
            // Scale by the oval width and height so that
            // each rounded corner is 0.5 units in radius.
            CGContextScaleCTM(context, ovalWidth, ovalHeight);
            // Unscale the rectangle width by the amount of x scaling.
            fw = CGRectGetWidth(rect) / ovalWidth;
            // Unscale the rectangle height by the amount of y scaling.
            fh = CGRectGetHeight(rect) / ovalHeight;
            // Start at the right edge of the rectangle, at the midpoint in y.
            CGContextMoveToPoint(context, fw, fh/2);
            // ***** Segment 1 *****
            CGContextAddArcToPoint(context, fw, fh, fw/2, fh, 0.5);
            // ***** Segment 2 *****
            CGContextAddArcToPoint(context, 0, fh, 0, fh/2, 0.5);
            // ***** Segment 3 *****
            CGContextAddArcToPoint(context, 0, 0, fw/2, 0, 0.5);
            // ***** Segment 4 *****
            CGContextAddArcToPoint(context, fw, 0, fw, fh/2, 0.5);
            // Close the path adds the last segment.
            CGContextClosePath(context);
        }
        CGContextRestoreGState(context);
    }
}

- (void)doRoundedRects:(CGContextRef)context {
    CGRect rect = {{10.0, 10.0}, {210.0, 150.0}};
    float ovalWidth = 10.0, ovalHeight = 100.0;
    CGContextSetLineWidth(context, 2.0);
    CGContextBeginPath(context);
    [self addRoundedRectToPath:context rect:rect ovalWidth:ovalWidth ovalHeight:ovalHeight];
    CGContextSetRGBStrokeColor(context, 1.0, 0.0, 0.0, 1.0);
    CGContextDrawPath(context, kCGPathStroke);
    
    CGContextSetRGBStrokeColor(context, 0.0, 1.0, 0.0, 1.0);
    //    CGContextTranslateCTM(context, CGRectGetWidth(rect)/10.0, CGRectGetHeight(rect)/10.0);
    CGContextAddEllipseInRect(context, rect);
    CGContextDrawPath(context, kCGPathStroke);
}

-(void)doStrokedElipses:(CGContextRef)context {
    CGContextTranslateCTM(context, 150.0, 180.0);
    CGContextSetLineWidth(context, 10.0);
    // Draw ellipse 1 with a uniform stroke
    CGContextSaveGState(context); {
        // Scale the CTM so that the circular arc will be elliptical
        CGContextScaleCTM(context, 2, 1);
        CGContextBeginPath(context);
        // Create an arc that is a circle.
        CGContextAddArc(context, 0.0, 0.0, 45.0, 0.0, 2*M_PI, 0);
        // Restore the context parameter prior to stroking the path.
        // CGContextRestoreGState does not affect the path in the context.
    }
    CGContextRestoreGState(context);
    CGContextStrokePath(context);
    
    CGContextTranslateCTM(context, 220.0, 0.0);
    // Draw ellipse 2 with non-uniform stroke.
    CGContextSaveGState(context); {
        // Scale the CTM so that the circular arc will be elliptical
        CGContextScaleCTM(context, 2, 1);
        CGContextBeginPath(context);
        // Create an arc that is a circle.
        CGContextAddArc(context, 0.0, 0.0, 45.0, 0, 2*M_PI, 0);
        CGContextStrokePath(context);
        CGContextRestoreGState(context);
    }
}

- (void)doJoins:(CGContextRef)context {
    CGContextTranslateCTM(context, 15.0, 20.0);
    CGContextSetLineWidth(context, 10);
    CGContextBeginPath(context);
    CGContextMoveToPoint(context, 0.0, 0.0);
    CGContextAddLineToPoint(context, 100.0, 0.0);
    CGContextAddLineToPoint(context, 0.0, -21.0);
    
    CGContextMoveToPoint(context, 170.0, 0.0);
    CGContextAddLineToPoint(context, 250.0, 0.0);
    CGContextAddLineToPoint(context, 170.0, -15.0);
    CGContextStrokePath(context);
}
@end
