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

- (instancetype)initFrontWithCoordinates:(CGPoint)coordinates;
- (instancetype)initBackWithCoordinates:(CGPoint)coordinates;

@end
