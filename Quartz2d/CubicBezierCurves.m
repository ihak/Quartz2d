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
    //    CGContextSetRGBFillColor(context, 1, 0, 0, 1);
    //    CGContextFillRect(context, CGRectMake(0, 0, 200, 100));
    //    CGContextSetRGBFillColor(context, 0, 0, 1, 0.5);
    //    CGContextFillRect(context, CGRectMake(0, 0, 100, 200));
    
    [self doEgg:context];
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

@end
