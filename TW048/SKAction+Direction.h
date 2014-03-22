//
//  SKAction+Direction.h
//  TW048
//
//  Created by Niklas Riekenbrauck on 22.03.14.
//  Copyright (c) 2014 Niklas Riekenbrauck. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface SKAction (Direction)

typedef enum Direction:NSInteger {
    kDirectionUp,
    kDirectionDown,
    kDirectionLeft,
    kDirectionRight
} Direction;

@end
