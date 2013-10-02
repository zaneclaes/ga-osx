//
//  GoogleAnalyticsReporting.h
//  Google Analytics Reports
//
//  Created by SalesTech on 7/18/13.
//  Copyright (c) 2013 SalesTech. All rights reserved.
//

#import <Foundation/Foundation.h>

// base url is the url where you have put your server files
#define BASE_URL @"http://You_Site_where_the_Servre_is"

@class WebView;

@interface GoogleAnalyticsReporting : NSObject

- (BOOL)sendEventWithCategory:(NSString *)category
                   withAction:(NSString *)action
                    withLabel:(NSString *)label
                    withValue:(NSNumber *)value;

- (BOOL)sendTimingWithCategory:(NSString *)category
                     withValue:(NSTimeInterval)time
                      withName:(NSString *)name
                     withLabel:(NSString *)label;

- (BOOL)sendView:(NSString *)screen;

- (id)initWithURL:(NSString*)url inWindow:(NSWindow*)window;

@end
