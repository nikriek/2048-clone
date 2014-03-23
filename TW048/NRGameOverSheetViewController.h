//
//  NRGameOverSheetViewController.h
//  TW048
//
//  Created by Niklas Riekenbrauck on 22.03.14.
//  Copyright (c) 2014 Niklas Riekenbrauck. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIViewController+TargetViewController.h"

@interface NRGameOverSheetViewController : UIViewController

- (IBAction)pushedRestart:(UIButton *)sender;
- (IBAction)pushedTweet:(UIButton *)sender;
- (IBAction)pushedFacebook:(UIButton *)sender;

@property (weak, nonatomic) IBOutlet UILabel *statusTextLabel;
@property (weak, nonatomic) IBOutlet UILabel *scoreTextLabel;

@property (weak, nonatomic) IBOutlet UIButton *restartButton;
@property (weak, nonatomic) IBOutlet UIButton *tweetButton;
@property (weak, nonatomic) IBOutlet UIButton *facebookButton;


@property (nonatomic) NSInteger score;

@end
