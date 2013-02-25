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

- (IBAction)pisteButton:(UIButton*)sender;

@property (weak, nonatomic) IBOutlet UIButton *pisteButton1;

@property (weak, nonatomic) IBOutlet UIButton *pisteButton2;

- (IBAction)moveButton:(UIPanGestureRecognizer *)recognizer;

- (IBAction)changeTitle:(UILongPressGestureRecognizer *)recognizer;

- (IBAction)lock:(UITapGestureRecognizer *)recognizer;
@property (nonatomic, retain) UITextField *changerTitreField;

@property (strong, nonatomic) IBOutlet UITapGestureRecognizer *doubleTap;
@property (strong, nonatomic) IBOutlet UITapGestureRecognizer *doubleTap2;



@end
