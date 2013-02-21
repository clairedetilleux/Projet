//
//  LiveModeViewController.h
//  Projet
//
//  Created by Claire Detilleux on 04/02/13.
//  Copyright (c) 2013 ISMIN-M&S. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DownloadManager.h"


@interface LiveModeViewController : UIViewController <UIAlertViewDelegate>
{
    NSMutableArray *sequence;
    UITextField *changeTitleField;
    
    UIView *changeTitleView;
    
    UIAlertView *changeTitleAlert;
}


@property (nonatomic, retain) NSDateFormatter *dateFormatter;
@property (nonatomic, retain) NSDateFormatter *datePisteFormatter;

@property (strong, nonatomic) IBOutlet UILabel *stopwatchLabel;


- (IBAction)playButton:(id)sender;
- (IBAction)pauseButton:(id)sender;
- (IBAction)rewButton:(id)sender;
- (IBAction)ffButton:(id)sender;

- (IBAction)pisteButton:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *pisteButton1;

@property (weak, nonatomic) IBOutlet UIButton *pisteButton2;
@property (strong, nonatomic) IBOutlet UILabel *debugLabel;

- (IBAction)test:(UIPanGestureRecognizer *)recognizer;
- (IBAction)changeTitle:(UILongPressGestureRecognizer *)recognizer;


@property (nonatomic, retain) UITextField *changerTitreField;



@end
