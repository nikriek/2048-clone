//
//  NRMyScene.h
//  TW048
//

//  Copyright (c) 2014 Niklas Riekenbrauck. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "SKAction+Direction.h"
#import "NRTileMap.h"

@interface NRGameScene : SKScene

@property (nonatomic,retain) NRTileMap *mapTiles;

@end
