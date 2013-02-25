//
//  DownloadDelegate.h
//  MSToolTips
//
//  Created by Marian Paul on 12/09/12.
//  Copyright (c) 2012 Marian Paul. All rights reserved.
//

#import <Foundation/Foundation.h>

// Do not import DownloadOperation header, use @class for a forward declaration
@class DownloadOperation;

@protocol DownloadDelegate <NSObject>
// Will be fired when the download start to occurs
- (void) downloadOperation:(DownloadOperation *)operation didStartLoadingRequest:(NSMutableURLRequest*)request;
// Will be fired if there is any issue
- (void) downloadOperation:(DownloadOperation *)operation didFailWithError:(NSError*)error;
// Will be fired at the end and return the object loaded (we assume that we are working with JSON files). The object can either be an NSArray or an NSDictionary
- (void) downloadOperation:(DownloadOperation *)operation didLoadObject:(id)object;
@end
