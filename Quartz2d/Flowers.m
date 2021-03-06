//
//  Flowers.m
//  Quartz2d
//
//  Created by Hassan Ahmed on 09/02/2018.
//  Copyright © 2018 Hassan Ahmed. All rights reserved.
//

#import "Flowers.h"

@implementation Flowers

- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
    
    // Drawing code here.
    CGContextRef context = [NSGraphicsContext currentContext].graphicsPort;
    CGContextTranslateCTM(context, 100.0, 100.0);
//    [self doRandomDots:context];
    [self doPetal:context];
    
}

- (void)doPetals:(CGContextRef) context {
    CGPoint p0 = {0.0, 0.0}, p1 = {-10.0, 0.0};
    CGPoint c1 = {-100.0, 100.0}, c2 = {100.0, 100.0};
    CGContextTranslateCTM(context, 100.0, 5.0);
    
    [self createBoundingRect:context p0:p0 p1:p1 c1:c1 c2:c2];
    
    CGContextSetLineWidth(context, 2);
    CGContextSetRGBStrokeColor(context, 0.0, 0.0, 0.0, 1.0);
    CGContextBeginPath(context);
    CGContextMoveToPoint(context, p0.x, p0.y);
    CGContextAddCurveToPoint(context, c1.x, c1.y, c2.x, c2.y, p1.x, p1.y);
    CGContextDrawPath(context, kCGPathStroke);
}

- (void)doRandomDots:(CGContextRef)context {
    CGRect rect = {{0.0, 0.0}, {50.0, 50.0}};
    [self doRandomDots:context inRect:rect count:500];
}

- (void)doRandomDots:(CGContextRef)context inRect:(CGRect)rect count:(int)count {
    CGContextSetRGBFillColor(context, 1.0, 0.0, 0.0, 1.0);
    CGContextFillRect(context, rect);
    
    CGContextSetRGBFillColor(context, 1.0, 1.0, 1.0, 1.0);
    CGContextBeginPath(context);
    for (int i = 0; i < count; i++) {
        int x = arc4random_uniform(CGRectGetWidth(rect));
        int y = arc4random_uniform(CGRectGetHeight(rect));
        CGContextMoveToPoint(context, x, y);
        CGContextAddArc(context, x, y, 2.0, 0.0, 2*M_PI, 0);
    }
    CGContextFillPath(context);
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

- (void)doPetal:(CGContextRef)context {
    CGContextSetRGBFillColor(context, 1.0, 0.0, 0.0, 1.0);
    CGContextSetRGBStrokeColor(context, 0.0, 0.0, 1.0, 1.0);

    int petals = 18;
    
    CGPoint p0 = {0.0, 0.0};
    CGPoint c1 = {25.0, 50.0};
    CGPoint c2 = {75.0, 50.0};
    CGPoint p1 = {100.0, 0.0};

    CGPathRef path = [self createPetalPath:context p0:p0 p1:p1 c1:c1 c2:c2];
    
    CGFloat rotationAngle = (2*M_PI)/petals;
    for (int i = 0; i < petals; i++) {
        CGContextAddPath(context, path);
        CGContextRotateCTM(context, rotationAngle);
    }
    
    CGContextStrokePath(context);
}

- (CGPathRef)createPetalPath:(CGContextRef)context p0:(CGPoint)p0 p1:(CGPoint)p1 c1:(CGPoint)c1 c2:(CGPoint)c2 {
    
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, p0.x, p0.y);
    CGPathAddCurveToPoint(path, NULL, c1.x, c1.y, c2.x, c2.y, p1.x, p1.y);
    CGPathAddCurveToPoint(path, NULL, c2.x, -c2.y, c1.x, -c1.y, p0.x, p0.y);
    CGPathCloseSubpath(path);
    
    return path;
}

@end
