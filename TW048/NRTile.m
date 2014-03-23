//
//  NRTile.m
//  TW048
//
//  Created by Niklas Riekenbrauck on 21.03.14.
//  Copyright (c) 2014 Niklas Riekenbrauck. All rights reserved.
//

#import "NRTile.h"

@implementation NRTile {
    SKLabelNode *label;
}
@synthesize currentValue = _currentValue;


- (instancetype)initWithPosition:(CGPoint)position
{
    self = [super init];
    if (self) {
        [self setPath:CGPathCreateWithRoundedRect(CGRectMake(position.x, position.y, 60.0,60.0), 4, 4, nil)];
        self.lineWidth = 0.0;
        
        label = [SKLabelNode labelNodeWithFontNamed:@"Helevetica Neue"];
        label.position = CGPointMake(position.x+30.0, position.y+30.0);
        label.verticalAlignmentMode = SKLabelVerticalAlignmentModeCenter;
        label.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeCenter;
        [self addChild:label];
    }
    return self;
}

- (instancetype)initFrontWithPosition:(CGPoint)position
{
    self = [self initWithPosition:position];
    if (self) {
        [self setCurrentValue: 2];
    }
    return self;
}

- (instancetype)initBackWithPosition:(CGPoint)position
{
    self = [self initWithPosition:position];
    if (self) {
        [self setCurrentValue: 0];
    }
    return self;
}

-(void)setCurrentValue:(NSInteger)currentValue {
    _currentValue = currentValue;
    
    //Set background depending on value
    switch (self.currentValue) {
        case 0:
            self.strokeColor = self.fillColor = [UIColor colorWithRed:238.0/255.0 green:228.0/255.0 blue:218.0/255.0 alpha:0.35];
            break;
        case 2:
            self.strokeColor = self.fillColor = UIColorFromRGB(0xeee4da);
            break;
        case 4:
            self.strokeColor = self.fillColor = UIColorFromRGB(0xede0c8);
            break;
        case 8:
            self.strokeColor = self.fillColor = UIColorFromRGB(0xf2b179);
            break;
        case 16:
            self.strokeColor = self.fillColor = UIColorFromRGB(0xf59563);
            break;
        case 32:
            self.strokeColor = self.fillColor = UIColorFromRGB(0xf67c5f);
            break;
        case 64:
            self.strokeColor = self.fillColor = UIColorFromRGB(0xf65e3b);
            break;
        case 128:
            self.strokeColor = self.fillColor = UIColorFromRGB(0xedcf72);
            break;
        case 256:
            self.strokeColor = self.fillColor = UIColorFromRGB(0xedcc61);
            break;
        case 512:
            self.strokeColor = self.fillColor = UIColorFromRGB(0xedc850);
            break;
        case 1024:
            self.strokeColor = self.fillColor = UIColorFromRGB(0xedc53f);
            break;
        case 2048:
            self.strokeColor = self.fillColor = UIColorFromRGB(0xedc22e);
            break;
        case 4096:
            self.strokeColor = self.fillColor = UIColorFromRGB(0x000000);
            break;
        default:
            self.strokeColor = self.fillColor = UIColorFromRGB(0x3c3a32);
            break;
    }
    
    //pop out animation
    if (currentValue != 0) {
        SKAction *popOutScale = [SKAction scaleTo:1.1 duration:0.05];
        SKAction *popOutMove = [SKAction moveByX:-3.0 y:-3.0 duration:0.05];
        SKAction *popOut = [SKAction group:@[popOutScale,popOutMove]];
        
        SKAction *popInScale = [SKAction scaleTo:1.0 duration:0.05];
        SKAction *popInMove = [SKAction moveByX:3.0 y:3.0 duration:0.05];
        SKAction *popIn = [SKAction group:@[popInScale,popInMove]];
        
        SKAction *sequence = [SKAction sequence:@[popOut,popIn]];
        [self runAction:sequence];
    }
    
    // Set Label font color
    if (currentValue < 8) {
        label.fontColor = UIColorFromRGB(0x776e65);
    } else {
        label.fontColor = UIColorFromRGB(0xFFFFFF);
    }
    
    // Set the label text
    if (currentValue == 0) {
        [label setHidden:YES];
    } else {
        [label setHidden:NO];
        label.text = [NSString stringWithFormat:@"%i",currentValue];
    }
    
    // Size down the Label
    while (label.frame.size.width >= 60.0) {
        label.fontSize--;
    }
}

@end
