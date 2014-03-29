//
//  NRTile.m
//  TW048
//
//  Created by Niklas Riekenbrauck on 21.03.14.
//  Copyright (c) 2014 Niklas Riekenbrauck & Georg Zänker. All rights reserved.
//

#import "NRTile.h"

@implementation NRTile {
    SKLabelNode *label;
}
@synthesize value = _value;
@synthesize coordinates = _coordinates;

#pragma mark Initialisation Methods

- (instancetype)initWithCoordinates:(CGPoint)coordinates
{
    self = [super init];
    if (self) {
        CGPoint position = [NRTile positionForCoordinates:coordinates];
        [self setPath:CGPathCreateWithRoundedRect(CGRectMake(position.x, position.y, 60.0,60.0), 4, 4, nil)];
        self.lineWidth = 0.0;
        self.coordinates = coordinates;
        
        label = [SKLabelNode labelNodeWithFontNamed:@"Helevetica Neue"];
        label.position = CGPointMake(position.x+30.0, position.y+30.0);
        label.verticalAlignmentMode = SKLabelVerticalAlignmentModeCenter;
        label.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeCenter;
        [self addChild:label];
    }
    return self;
}
- (instancetype)initFrontWithCoordinates:(CGPoint)coordinates
{
    self = [self initWithCoordinates:coordinates];
    if (self) {
        [self setValue: 2];
        self.hasJustBeenCombined = YES;
    }
    return self;
}
- (instancetype)initBackWithCoordinates:(CGPoint)coordinates
{
    self = [self initWithCoordinates:coordinates];
    if (self) {
        [self setValue: 0];
        // Default value has to be set, but is not going to be used later on
        self.hasJustBeenCombined = NO;
    }
    return self;
}

#pragma mark Changing the Value of a Tile

-(void)setValue:(NSInteger)currentValue {
    _value = currentValue;
    
    //Set background depending on value
    switch (self.value) {
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
        case 8192:
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

#pragma mark Convert logical units into graphical units

+(CGPoint)positionForCoordinates:(CGPoint)coordinates {
    CGFloat xCoordinate = 8.0 + coordinates.x * 8.0 + coordinates.x * 60.0;
    CGFloat yCoordinate = 8.0 + coordinates.y * 8.0 + coordinates.y * 60.0;;
    return CGPointMake(xCoordinate, yCoordinate);
}
+(CGVector)distanceForVector:(CGVector)vector {
    CGFloat dx = vector.dx * 8.0 + vector.dx * 60.0;
    CGFloat dy = vector.dy * 8.0 + vector.dy * 60.0;;
    return CGVectorMake(dx, dy);
}

#pragma mark Basic Vector Methods
// These should actually be a Categorie/Subclass/Extension of CGGeometry, but as I don't know how to do that, they stick here
+(CGVector)oppositeDirectionOf:(CGVector)vDirection {
    return CGVectorMake(-vDirection.dx, -vDirection.dy);
}
+(CGVector)clockwiseDirectionOf:(CGVector)vDirection {
    return CGVectorMake(vDirection.dy, -vDirection.dx);
}
+(CGPoint)translatePoint:(CGPoint)point intoDirection:(CGVector)vDirection {
    return CGPointMake(point.x + vDirection.dx, point.y + vDirection.dy);
}

@end
