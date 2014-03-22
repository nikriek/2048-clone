//
//  NRViewController.h
//  TW048
//

//  Copyright (c) 2014 Niklas Riekenbrauck. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SpriteKit/SpriteKit.h>

@interface NRGameViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *bestLabel;

@property (weak, nonatomic) IBOutlet UIView *scoreBackgroundView;
@property (weak, nonatomic) IBOutlet UIView *bestBackgroundView;

@property (weak, nonatomic) IBOutlet SKView *gamepadView;

//Swipe Recognizer
@property (strong, nonatomic) IBOutlet UISwipeGestureRecognizer *upSwipeGestureRecognizer;
@property (strong, nonatomic) IBOutlet UISwipeGestureRecognizer *downSwipeGestureRecognizer;
@property (strong, nonatomic) IBOutlet UISwipeGestureRecognizer *leftSwipeGestureRecognizer;
@property (strong, nonatomic) IBOutlet UISwipeGestureRecognizer *rightSwipeGestureRecognizer;

- (IBAction)madeSwipeGesture:(UISwipeGestureRecognizer *)sender;

@end
