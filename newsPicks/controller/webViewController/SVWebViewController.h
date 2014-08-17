//
//  SVWebViewController.h
//
//  Created by Sam Vermette on 08.11.10.
//  Copyright 2010 Sam Vermette. All rights reserved.
//
//  https://github.com/samvermette/SVWebViewController

#import <MessageUI/MessageUI.h>

#import "SVModalWebViewController.h"

@interface SVWebViewController : UIViewController
{
   
}
- (id)initWithAddress:(NSString*)urlString;
- (id)initWithURL:(NSURL*)URL;
@property (nonatomic, strong) NSURL *URL;
@property (nonatomic, strong) NSString *elementId;
@property (nonatomic, assign) NSInteger type;
@property (nonatomic, assign) NSString *subelementtitle;
@property (nonatomic, readwrite) SVWebViewControllerAvailableActions availableActions;

@end
