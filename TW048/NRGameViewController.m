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
#import "SoundPlayer.h"
#import "NRGameOverSheetViewController.h"

@implementation NRGameViewController {
    NRGameScene * scene;
    SoundPlayer *soundPlayer;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // SoundPlayer
    soundPlayer = [SoundPlayer new];
    [soundPlayer playBackgroundSound];
    
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
    
    
    //make property weak to use it in blocks
    __weak typeof(self) weakSelf = self;
    
    // Create and configure the scene.
    scene = [NRGameScene sceneWithSize:skView.bounds.size];
    scene.scaleMode = SKSceneScaleModeAspectFill;
    [scene.tiles setNewScoreBlock:^(NSInteger newScore, NSInteger offset) {
        //Actions for new score
        [weakSelf updateScore:newScore withScoreOffset:offset];
    }];
    
    [scene.tiles setFinishedGameBlock:^(BOOL success, NSInteger score) {
        //[soundPlayer stopBackgroundSound];
        [weakSelf showPopUpWithScore:score andSuccess:success];
    }];
    
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
-(void)showPopUpWithScore:(NSInteger)score andSuccess:(BOOL)success {
    UIViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"sheet"];
    
    // present form sheet with view controller
    [self mz_presentFormSheetWithViewController:vc animated:YES completionHandler:^(MZFormSheetController *formSheetController) {
    
    }];
    
}

-(void)updateScore:(NSInteger)score withScoreOffset:(NSInteger)offset {
    self.scoreLabel.text = [NSString stringWithFormat:@"%i",(int)score];
    
}

- (IBAction)madeSwipeGesture:(UISwipeGestureRecognizer *)sender {
    [self showPopUpWithScore:100 andSuccess:YES];
    
    if (sender == self.upSwipeGestureRecognizer) {
         [scene.tiles performedSwipeGestureInDirection:kDirectionUp];
    } else if (sender == self.downSwipeGestureRecognizer) {
        [scene.tiles performedSwipeGestureInDirection:kDirectionDown];
    } else if (sender == self.leftSwipeGestureRecognizer) {
        [scene.tiles performedSwipeGestureInDirection:kDirectionLeft];
    } else if (sender == self.rightSwipeGestureRecognizer) {
        [scene.tiles performedSwipeGestureInDirection:kDirectionRight];
    }
}
@end
