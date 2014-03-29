//
//  NRMyScene.h
//  TW048
//

//  Copyright (c) 2014 Niklas Riekenbrauck & Georg Zänker. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "NRTileMap.h"

@interface NRGameScene : SKScene

@property (nonatomic,retain) NRTileMap *mapTiles;

@end
