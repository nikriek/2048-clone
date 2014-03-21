//
//  NRViewController.m
//  TW048
//
//  Created by Niklas Riekenbrauck on 20.03.14.
//  Copyright (c) 2014 Niklas Riekenbrauck. All rights reserved.
//

#import "NRGameViewController.h"
#import "NRGameScene.h"
#import <QuartzCore/QuartzCore.h>

@implementation NRGameViewController {
    NRGameScene * scene;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    //Make round corners
    self.scoreBackgroundView.layer.cornerRadius = 4.0;
    self.scoreBackgroundView.layer.masksToBounds = YES;
    self.bestBackgroundView.layer.cornerRadius = 4.0;
    self.bestBackgroundView.layer.masksToBounds = YES;
    self.gamepadView.layer.cornerRadius = 8.0;
    self.gamepadView.layer.masksToBounds = YES;
    
    // Configure the view.
    SKView * skView = (SKView *)self.gamepadView;
    skView.showsFPS = YES;
    skView.showsNodeCount = YES;
    
    // Create and configure the scene.
    scene = [NRGameScene sceneWithSize:skView.bounds.size];
    scene.scaleMode = SKSceneScaleModeAspectFill;
    
    // Present the scene.
    [skView presentScene:scene];
}

- (BOOL)shouldAutorotate
{
    return NO;
}

- (NSUInteger)supportedInterfaceOrientations
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return UIInterfaceOrientationMaskAllButUpsideDown;
    } else {
        return UIInterfaceOrientationMaskAll;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

- (IBAction)madeSwipeGesture:(UISwipeGestureRecognizer *)sender {
    if (sender == self.upSwipeGestureRecognizer) {
         [scene performedSwipeGestureInDirection:kDirectionUp];
    } else if (sender == self.downSwipeGestureRecognizer) {
        [scene performedSwipeGestureInDirection:kDirectionDown];
    } else if (sender == self.leftSwipeGestureRecognizer) {
        [scene performedSwipeGestureInDirection:kDirectionLeft];
    } else if (sender == self.rightSwipeGestureRecognizer) {
        [scene performedSwipeGestureInDirection:kDirectionRight];
    }
}
@end
