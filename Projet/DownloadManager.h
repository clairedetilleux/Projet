//
//  DownloadManager.h
//  MSToolTips
//
//  Created by Marian Paul on 12/09/12.
//  Copyright (c) 2012 Marian Paul. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DownloadDelegate.h"

@interface DownloadManager : NSObject
{
    NSOperationQueue *_operationQueue;
}
+ (DownloadManager*)shared;

- (void) loadRequest:(NSMutableURLRequest*)request withDelegate:(id<DownloadDelegate>)delegate;
- (void) loadLocalFileName:(NSString*)filename withDelegate:(id<DownloadDelegate>)delegate;

@end
