//
//  NRTile.h
//  TW048
//
//  Created by Niklas Riekenbrauck on 21.03.14.
//  Copyright (c) 2014 Niklas Riekenbrauck & Georg Zänker. All rights reserved.
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

#pragma mark Basic Vector Methods
// These should actually be a Categorie/Subclass/Extension of CGGeometry, but as I don't know how to do that, they stick here
+(CGVector)oppositeDirectionOf:(CGVector)vDirection;
+(CGVector)clockwiseDirectionOf:(CGVector)vDirection;
+(CGPoint)translatePoint:(CGPoint)point intoDirection:(CGVector)vDirection;

@end
