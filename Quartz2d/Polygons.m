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
//    [self doPolygonsByArcs:context];
//    [self doStar:context];
//    [self doGoldenRect:context];
    [self doCaptainAmericaLogo:context];
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
    
    int sides = 7;
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

- (NSArray *)getVerticesofPolygonOfSize:(CGSize)size andSides:(int)sides {
    NSMutableArray *vertices = [NSMutableArray array];
    
    CGFloat radius = floorf( 1.0 * MIN(size.width, size.height) / 2.0f );
    
    for (int n = 0; n < sides; n++) {
        CGFloat rotationFactor = ((2 * M_PI) / sides) * (n+1);
        CGFloat x = cos(rotationFactor) * radius;
        CGFloat y = sin(rotationFactor) * radius;
        
        [vertices addObject:[NSValue valueWithPoint:CGPointMake(x, y)]];
    }

    return vertices;
}

- (void)doStar:(CGContextRef)context {
    CGContextSetRGBFillColor(context, 1.0, 0.0, 0.0, 1.0);
    CGContextSetRGBStrokeColor(context, 0.0, 1.0, 0.0, 1.0);
    CGContextSetLineWidth(context, 2.0);
    
    NSArray *points = [self getVerticesofPolygonOfSize:CGSizeMake(200.0, 200.0) andSides:10];
    CGContextBeginPath(context);
    
    for (int i = 0; i < points.count; i++) {
        CGPoint pointValue = ((NSValue *)points[i]).pointValue;
        CGContextMoveToPoint(context, pointValue.x, pointValue.y);
        
        int nextIndex = (i + 6) % points.count;
        CGPoint pointValue2 = ((NSValue *)points[nextIndex]).pointValue;
        CGContextAddLineToPoint(context, pointValue2.x, pointValue2.y);
    }
    
    CGContextDrawPath(context, kCGPathStroke);
}

- (void)doGoldenRect:(CGContextRef)context {
    CGRect rect = {{10.0, 10.0}, {100.0, 100.0}};
    
    CGFloat a = MIN(rect.size.width, rect.size.height);
    CGFloat a_plus_b = a*1.617;
    
    CGRect goldenRect = CGRectMake(rect.origin.x, rect.origin.y, a_plus_b, a);
    CGContextFillRect(context, goldenRect);
}

- (void)doCaptainAmericaLogo:(CGContextRef)context {
    CGRect rect = CGRectMake(0.0, 0.0, 1024.0, 1024.0);
    CGPoint center = CGPointMake(CGRectGetWidth(rect)/2.0, CGRectGetHeight(rect)/2.0);
    CGFloat radius1 = CGRectGetWidth(rect)/2.0;
    CGFloat radius2 = radius1 - (radius1 * 0.20);
    CGFloat radius3 = radius2 - (radius1 * 0.20);
    CGFloat radius4 = radius3 - (radius1 * 0.20);
    CGSize starSize = CGSizeMake(radius4 * 2, radius4 * 2);
    
    NSColor *red = [NSColor colorWithRed:170.0/256.0 green:20.0/256.0 blue:40.0/256.0 alpha:1.0];
    NSColor *blue = [NSColor colorWithRed:1.0/256.0 green:3.0/256.0 blue:66.0/256.0 alpha:1.0];
    
    // ***** Circle 1 *****
    CGMutablePathRef circle1 = CGPathCreateMutable();
    CGPathAddArc(circle1, NULL, center.x, center.y, radius1, 0, 2*M_PI, 0);
    
    CGContextSetFillColorWithColor(context, red.CGColor);
    CGContextAddPath(context, circle1);
    CGContextDrawPath(context, kCGPathFill);
    
    // ***** Circle 2 *****
    CGMutablePathRef circle2 = CGPathCreateMutable();
    CGPathAddArc(circle2, NULL, center.x, center.y, radius2, 0, 2*M_PI, 0);
    
    CGContextSetFillColorWithColor(context, [NSColor whiteColor].CGColor);
    CGContextAddPath(context, circle2);
    CGContextDrawPath(context, kCGPathFill);
    
    // ***** Circle 3 *****
    CGMutablePathRef circle3 = CGPathCreateMutable();
    CGPathAddArc(circle3, NULL, center.x, center.y, radius3, 0, 2*M_PI, 0);
    
    CGContextSetFillColorWithColor(context, red.CGColor);
    CGContextAddPath(context, circle3);
    CGContextDrawPath(context, kCGPathFill);
    
    // ***** Circle 4 *****
    CGMutablePathRef circle4 = CGPathCreateMutable();
    CGPathAddArc(circle4, NULL, center.x, center.y, radius4, 0, 2*M_PI, 0);
    
    CGContextSetFillColorWithColor(context, blue.CGColor);
    CGContextAddPath(context, circle4);
    CGContextDrawPath(context, kCGPathFill);
    
    // ***** Star *****
    NSArray *points = [self getVerticesofPolygonOfSize:starSize andSides:5];
    
    CGMutablePathRef starPath = CGPathCreateMutable();
    NSValue *value = points[0];
    CGPoint pointValue = value.pointValue;
    CGAffineTransform transform = CGAffineTransformMakeTranslation(center.x, center.y);
    CGPathMoveToPoint(starPath, &transform, pointValue.x, pointValue.y);
    
    for (int i = 0; i < points.count; i++) {
        int nextIndex = (int) [points indexOfObject:value];
        nextIndex = (nextIndex + 2) % points.count;
        value = points[nextIndex];
        
        pointValue = value.pointValue;
        CGPathAddLineToPoint(starPath, &transform, pointValue.x, pointValue.y);
    }

    CGContextSetFillColorWithColor(context, [NSColor whiteColor].CGColor);
    CGContextAddPath(context, starPath);

    CGContextDrawPath(context, kCGPathFill);
    
    CFRelease(circle1);
    CFRelease(circle2);
    CFRelease(circle3);
    CFRelease(circle4);
    CFRelease(starPath);
}

@end
