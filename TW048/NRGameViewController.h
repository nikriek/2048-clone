//
//  NRViewController.h
//  TW048
//

//  Copyright (c) 2014 Niklas Riekenbrauck & Georg Zänker. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SpriteKit/SpriteKit.h>
#import "MZFormSheetController.h"

typedef enum GameOverType:BOOL {
    kGameWon,
    kGameLost
} GameOverType;

@interface NRGameViewController : MZFormSheetController 

@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *bestLabel;

@property (weak, nonatomic) IBOutlet UIView *scoreBackgroundView;
@property (weak, nonatomic) IBOutlet UIView *bestBackgroundView;

@property (weak, nonatomic) IBOutlet SKView *gamepadView;

//Swipe Recognizer with Outlet Collection
@property (strong, nonatomic) IBOutletCollection(UISwipeGestureRecognizer) NSArray *swipeGestureRecognizerCollection;


- (IBAction)madeSwipeGesture:(UISwipeGestureRecognizer *)sender;

-(void)prepareGame;
@end
