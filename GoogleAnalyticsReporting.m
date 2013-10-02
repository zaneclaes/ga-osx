//
//  GoogleAnalyticsReporting.m
//  Google Analytics Reports
//
//  Created by SalesTech on 7/18/13.
//  Copyright (c) 2013 SalesTech. All rights reserved.
//

#import "GoogleAnalyticsReporting.h"
#import <WebKit/WebKit.h>

@interface GoogleAnalyticsReporting ()
@property (nonatomic, strong) WebView *webView;
@property (nonatomic, strong) NSString *url;
@property (nonatomic, weak) NSWindow *window;
@end

@implementation GoogleAnalyticsReporting

- (id)initWithURL:(NSString*)url inWindow:(NSWindow*)window
{
  if ((self = [super init])) {
    self.url = url;
    self.window = window;
    [self setup];
  }
  return self;
}

- (void)setup {
  if(![NSThread isMainThread]) {
    [self performSelectorOnMainThread:@selector(setup) withObject:nil waitUntilDone:NO];
    return;
  }
  self.webView = [[WebView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
  [self.window.contentView addSubview:self.webView];
  NSURLRequest *urlRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:self.url]];
  [self.webView.mainFrame loadRequest:urlRequest];

}

- (void) delayedRetry:(NSDictionary*)params {
  [self callWebScriptMethod:[params objectForKey:@"method"]
              withArguments:[params objectForKey:@"arguments"]
                      tries:[[params objectForKey:@"tries"] intValue]+1];
}

- (BOOL)callWebScriptMethod:(NSString*)method withArguments:(NSArray *)arguments tries:(int)tries {
  if(![NSThread isMainThread]) {
    [self performSelectorOnMainThread:@selector(delayedRetry:) withObject:@{@"method":method,@"arguments":arguments,@"tries":@(tries)} waitUntilDone:NO];
    return NO;
  }
  if(self.webView.isLoading) {
    if(tries<3) {
      [self performSelector:@selector(delayedRetry:) withObject:@{@"method":method,@"arguments":arguments,@"tries":@(tries)} afterDelay:5.0];
    }
    return NO;
  }
  id ret = [[self.webView windowScriptObject] callWebScriptMethod:method withArguments:arguments];
  int v = [ret respondsToSelector:@selector(intValue)] && [ret intValue];
  return v != 0;
}

- (BOOL)sendTimingWithCategory:(NSString *)category
                     withValue:(NSTimeInterval)time
                      withName:(NSString *)name
                     withLabel:(NSString *)label {
  return [self callWebScriptMethod:@"trackTiming"
                     withArguments:[NSArray arrayWithObjects:category,[NSNumber numberWithDouble:time], name, label, nil] tries:0];
}

- (BOOL)sendEventWithCategory:(NSString *)category
                   withAction:(NSString *)action
                    withLabel:(NSString *)label
                    withValue:(NSNumber *)value {
  return [self callWebScriptMethod:@"trackEvent"
                     withArguments:[NSArray arrayWithObjects:category, action, label, value, nil] tries:0];
}


- (BOOL)sendView:(NSString *)screen {  
  return [self callWebScriptMethod:@"trackView"
                     withArguments:[NSArray arrayWithObjects:screen, nil] tries:0];
}

@end
