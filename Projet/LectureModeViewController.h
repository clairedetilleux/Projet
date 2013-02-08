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
    NSDateFormatter *dateFormatter;
}





@property (nonatomic, retain) NSDateFormatter *dateFormatter;



@property (nonatomic, retain) IBOutlet UILabel *label;



- (IBAction)rewButton:(id)sender;
- (IBAction)stopButton:(id)sender;
- (IBAction)playButton:(id)sender;
- (IBAction)pauseButton:(id)sender;
- (IBAction)ffButton:(id)sender;

- (NSDictionary *)userInfo;

@end
