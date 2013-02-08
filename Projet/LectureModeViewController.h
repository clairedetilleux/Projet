//
//  LectureModeViewController.h
//  Projet
//
//  Created by Claire Detilleux on 04/02/13.
//  Copyright (c) 2013 ISMIN-M&S. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LectureModeViewController : UIViewController




@property (weak, nonatomic) IBOutlet UILabel *temps;
// Texte à afficher dans le label temps
@property(nonatomic, copy) NSString *tps;

- (IBAction)rewButton:(id)sender;
- (IBAction)stopButton:(id)sender;
- (IBAction)playButton:(id)sender;
- (IBAction)pauseButton:(id)sender;
- (IBAction)ffButton:(id)sender;

- (NSDictionary *)userInfo;

@end
