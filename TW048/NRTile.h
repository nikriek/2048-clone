//
//  NRTile.h
//  TW048
//
//  Created by Niklas Riekenbrauck on 21.03.14.
//  Copyright (c) 2014 Niklas Riekenbrauck. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface NRTile : SKShapeNode

@property (nonatomic) NSInteger value;
@property (nonatomic) CGPoint coordinates;
@property (nonatomic) BOOL hasJustBeenCombined;

#pragma mark Initialisation Methods
- (instancetype)initFrontWithCoordinates:(CGPoint)coordinates;
- (instancetype)initBackWithCoordinates:(CGPoint)coordinates;

#pragma mark Convert logical units into graphical units
+ (CGPoint)positionForCoordinates:(CGPoint)coordinates;
+ (CGVector)distanceForVector:(CGVector)vector;

@end
