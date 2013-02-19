//
//  LiveModeViewController.m
//  Projet
//
//  Created by Claire Detilleux on 04/02/13.
//  Copyright (c) 2013 ISMIN-M&S. All rights reserved.
//

#import "LiveModeViewController.h"
#import "Piste.h"

@interface LiveModeViewController ()

@property (strong, nonatomic) NSTimer *stopWatchTimer;      // Store the timer that fires after a certain time
@property (strong, nonatomic) NSDate *startDate;            // Stores the date of the click on the start button

@property (strong, nonatomic) NSDate *ffDate;               // Stores the date of the click on the ff button

@property (strong, nonatomic) NSDate *piste1;               // Stores the date of the click on the piste1 button


@end

@implementation LiveModeViewController
@synthesize texte = _texte;
@synthesize pisteButton1 = _pisteButton1;
@synthesize pisteButton2 = _pisteButton2;
@synthesize debugLabel = _debugLabel;
@synthesize stopwatchLabel;


/************ isButtonClicked ************/
int playButtonClicked;

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)viewDidUnload
{
    [self setStopwatchLabel:nil];
    [self setPisteButton1:nil];
    [self setPisteButton2:nil];
    [self setDebugLabel:nil];
    [self setTexte:nil];
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	// Forcer le landscape
    return UIDeviceOrientationIsLandscape(interfaceOrientation);
}


#pragma marks - Timer Methods

- (void)updateTimer
{
    // Create date from the elapsed time
    NSDate *currentDate = [NSDate date];
    NSTimeInterval timeInterval = [currentDate timeIntervalSinceDate:self.startDate];
    NSDate *timerDate = [NSDate dateWithTimeIntervalSince1970:timeInterval];
    
    // Create a date formatter
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"HH:mm:ss.S"];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0.0]];
    
    
    NSString *timeStringDebugTimerDate = [dateFormatter stringFromDate:timerDate];
    NSLog(timeStringDebugTimerDate);
    
    // Format the elapsed time and set it to the label
    NSString *timeString = [dateFormatter stringFromDate:timerDate];
    self.stopwatchLabel.text = timeString;
} //updateTimer


# pragma marks - Timer Manager Methods

- (IBAction)playButton:(id)sender {
    playButtonClicked = 1;
    
    self.startDate = [NSDate date];
    
    // Create the stop watch timer that fires every 100 ms
    self.stopWatchTimer = [NSTimer scheduledTimerWithTimeInterval:1.0/10.0
                                                           target:self
                                                         selector:@selector(updateTimer)
                                                         userInfo:nil
                                                          repeats:YES];
} // startButton()

- (IBAction)pauseButton:(id)sender {
    [self.stopWatchTimer invalidate];
    self.stopWatchTimer = nil;
    [self updateTimer];
} // pauseButton()

- (IBAction)rewButton:(id)sender {
} // rewButton()

- (IBAction)ffButton:(id)sender {
} // ffButton()


#pragma marks - Piste Button

- (IBAction)pisteButton:(id)sender {
    
    self.piste1 = [NSDate date];
    
    // Récupère le temps passé depuis l'appuie sur playButton (temps affiché par le timer)
    NSTimeInterval timeIntervalPiste1 = [_piste1 timeIntervalSinceDate:self.startDate];
    NSDate *timerPiste1Date = [NSDate dateWithTimeIntervalSince1970:timeIntervalPiste1];
    
    // Create a date formatter
    NSDateFormatter *datePisteFormatter = [[NSDateFormatter alloc] init];
    [datePisteFormatter setDateFormat:@"HH:mm:ss.S"];
    [datePisteFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0.0]];
        
    // Affiche le moment d'appuie sur le bouton de piste 1
    NSString *time = [datePisteFormatter stringFromDate:timerPiste1Date];
   
    // Création d'un tableau pour recueillir les évènements
    sequence = [[NSMutableArray alloc] init];
    
    /* Le if prend la position du bouton sur la fenêtre
     * Quelque soit le titre de celui ci
     * C'est le titre du bouton physique qui est enregistré dans 
     * la séquence
     */
    if(sender == _pisteButton1){
        NSLog(_pisteButton1.currentTitle);
        // Envoie de la requête qui lance le jouet
        if(playButtonClicked == 1){
            NSLog(@"Bouton 1 appuyé !");
            // Le titre qui est enregistré est celui du bouton
            NSString * piste =  _pisteButton1.currentTitle;
            
            // Création d'un tableau 1x2 contenant cet évènement
            NSArray * tabPiste1 = [[NSArray alloc] init];
            tabPiste1 = [NSArray arrayWithObjects: time, piste, nil];
            sequence = [NSArray arrayWithArray:tabPiste1];
        }
    } else if (sender == _pisteButton2){
        if(playButtonClicked == 1){
            NSLog(@"Bouton 2 appuyé !");
            NSString * piste =  _pisteButton2.currentTitle;
            // Création d'un tableau 1x2 contenant cet évènement
            NSArray * tabPiste2 = [[NSArray alloc] init];
            tabPiste2 = [NSArray arrayWithObjects: time, piste, nil];
            sequence = [NSArray arrayWithArray:tabPiste2];
        }
    }
} // pisteButton()




- (IBAction)test:(UIPanGestureRecognizer *)recognizer {
    CGPoint translation = [recognizer translationInView:self.view];
    recognizer.view.center = CGPointMake(recognizer.view.center.x + translation.x,
                                         recognizer.view.center.y + translation.y);
    [recognizer setTranslation:CGPointMake(0, 0) inView:self.view];
}

- (IBAction)changeTitle:(UILongPressGestureRecognizer *) recognizer{
    NSLog(@"long press");
    
    _texte = [[UITextField alloc] initWithFrame:CGRectMake(10, 80, 80, 25)];
    [_texte setBorderStyle:UITextBorderStyleRoundedRect];
    [_texte setReturnKeyType:UIReturnKeyDone];
    _texte.delegate = self;
    [self.view addSubview:_texte];
}


// Comment changer le titre du bouton courant ?
-(BOOL)textFieldShouldReturn: (UITextField *)textField
{
    [textField resignFirstResponder];
    [_pisteButton2 setTitle:textField.text forState:UIControlStateNormal];
    return YES;
}

@end
