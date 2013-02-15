//
//  LectureModeViewController.h
//  Projet
//
//  Created by Claire Detilleux on 04/02/13.
//  Copyright (c) 2013 ISMIN-M&S. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LectureModeViewController : UIViewController{
    UILabel *label;
    NSTimer *pollingTimer;
    NSDate *timer;    
}





@property (nonatomic, retain) NSDateFormatter *dateFormatter;

@property (strong, nonatomic) IBOutlet UILabel *stopwatchLabel;

@property (nonatomic, retain) IBOutlet UILabel *label;


/************** Variables debug ************/
@property (weak, nonatomic) IBOutlet UILabel *tenSecLabel;

@property (weak, nonatomic) IBOutlet UILabel *fiveSecLabel;
/*******************************************/

- (IBAction)rewButton:(id)sender;
- (IBAction)stopButton:(id)sender;
- (IBAction)playButton:(id)sender;
- (IBAction)pauseButton:(id)sender;
- (IBAction)ffButton:(id)sender;

- (NSDictionary *)userInfo;



@end
