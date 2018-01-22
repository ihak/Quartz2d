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
    [self doDefaultRect:context];
}

- (void)drawCoordinateAxes:(CGContextRef)context {
    
    CGContextBeginPath(context);
    CGContextSetLineWidth(context, 2.0);
    
    CGContextMoveToPoint(context, -5.0, 0.0);
    for (int i = 1; i < 4; i++) {
        CGContextAddLineToPoint(context, 72.0 * i, 0.0);
        CGContextMoveToPoint(context, 72.0 * i, 5.0);
        CGContextAddLineToPoint(context, 72.0 * i, -5.0);
        CGContextMoveToPoint(context, 72.0 * i, 0.0);
    }
    
    CGContextDrawPath(context, kCGPathStroke);
    
    CGContextMoveToPoint(context, 0.0, -5.0);
    for (int i = 1; i < 4; i++) {
        CGContextAddLineToPoint(context, 0.0, 72.0 * i);
        CGContextMoveToPoint(context, -5.0, 72.0 * i);
        CGContextAddLineToPoint(context, 5.0, 72.0 * i);
        CGContextMoveToPoint(context, 0.0, 72.0 * i);
    }
    
    CGContextDrawPath(context, kCGPathStroke);
}

- (void)doDefaultRect:(CGContextRef)context {
    CGRect ourRect = {{0, 0}, {72.0, 72.0}};
    CGContextFillRect(context, ourRect);
    
    [self drawCoordinateAxes:context];
    [self doTranslationThenScale:context rect:ourRect];
//    [self doScaleThenTranslation:context rect:ourRect];
//    [self doRotateThenScale:context rect:ourRect];
//    [self doScaleThenRotate:context rect:ourRect];
}

- (void)doScaleThenTranslation:(CGContextRef)context rect:(CGRect)rect {
    CGContextSetRGBFillColor(context, 115.0/256.0, 158.0/256.0, 198.0/256.0, 1.0);
    CGContextScaleCTM(context, 2.0, 2.0);
    CGContextTranslateCTM(context, 72.0, 36.0);
    CGContextFillRect(context, rect);

}

- (void)doTranslationThenScale:(CGContextRef)context rect:(CGRect)rect {
    CGContextSetRGBFillColor(context, 242.0/256.0, 201.0/256.0, 128.0/256.0, 1.0);
    CGContextTranslateCTM(context, 72.0, 36.0);
    CGContextScaleCTM(context, 2.0, 2.0);
    CGContextFillRect(context, rect);
}

- (void)doScaleThenRotate:(CGContextRef)context rect:(CGRect)rect {
    CGContextSetRGBFillColor(context, 228.0/256.0, 155.0/256.0, 62.0/256.0, 0.5);
    CGContextScaleCTM(context, 0.5, 2.0);
    CGContextRotateCTM(context, (M_PI/180.0)*30);
    CGContextFillRect(context, rect);
}

- (void)doRotateThenScale:(CGContextRef)context rect:(CGRect)rect {
    CGContextSetRGBFillColor(context, 160.0/256.0, 129.0/256.0, 163.0/256.0, 0.5);
    CGContextRotateCTM(context, (M_PI/180.0)*30);
    CGContextScaleCTM(context, 0.5, 2.0);
    CGContextFillRect(context, rect);
}

@end
