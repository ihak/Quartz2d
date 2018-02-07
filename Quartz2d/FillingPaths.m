//
//  FillingPaths.m
//  Quartz2d
//
//  Created by Hassan Ahmed on 06/02/2018.
//  Copyright © 2018 Hassan Ahmed. All rights reserved.
//

#import "FillingPaths.h"

@implementation FillingPaths

- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
    
    // Drawing code here.
    CGContextRef context = [NSGraphicsContext currentContext].graphicsPort;
    CGContextSetRGBStrokeColor(context, 1.0, 0.0, 0.0, 1.0);
    
    CGContextBeginPath(context);
    CGContextMoveToPoint(context, 0, 0);
    CGContextAddLineToPoint(context, 100.0, 0.0);
    CGContextAddLineToPoint(context, 100.0, 100.0);
    CGContextAddLineToPoint(context, 0.0, 100.0);
    CGContextClosePath(context);
    
    CGContextMoveToPoint(context, 30.0, 30.0);
    CGContextAddLineToPoint(context, 70.0, 30.0);
    CGContextAddLineToPoint(context, 70.0, 70.0);
    CGContextAddLineToPoint(context, 30.0, 70.0);
    
    
    CGContextClosePath(context);
    
    
//    CGContextFillPath(context);
    CGContextDrawPath(context, kCGPathEOFillStroke);
//    CGContextEOFillPath(context);
}

@end
