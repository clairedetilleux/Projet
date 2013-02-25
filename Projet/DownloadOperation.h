//
//  DownloadOperation.h
//  MSToolTips
//
//  Created by Marian Paul on 12/09/12.
//  Copyright (c) 2012 Marian Paul. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DownloadDelegate.h"

@interface DownloadOperation : NSOperation

// Properties from the init method
@property (nonatomic, strong) NSMutableURLRequest *request;
@property (nonatomic, assign) id <DownloadDelegate> delegate;
@property (nonatomic, strong) NSString *localFileName; // This should be remove one day


// This is the method which will request the data from the ULR request.
- (id) initWithRequest:(NSMutableURLRequest*)request andDelegate:(id<DownloadDelegate>) delegate;
// This is a temp method to load files from local. This should not be in used at the end of the project
- (id) initWithLocalFileName:(NSString*)fileName andDelegate:(id<DownloadDelegate>) delegate;

@end
