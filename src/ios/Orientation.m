//
//  Orientation.m
//  PhoneGapLib
//
//  Created by Wei Li on 11/10/2011.
//  Copyright 2011 FeedHenry. All rights reserved.
//

#import "Orientation.h"

#define degreesToRadian(x) (M_PI * (x) / 180.0)

@implementation Orientation

- (void) setOrientation:(CDVInvokedUrlCommand*)command
{
	NSString* ori = [command.arguments objectAtIndex:0];
	Boolean statusBarHidden = [UIApplication sharedApplication].statusBarHidden;
	UIInterfaceOrientation currentOri = [[UIApplication sharedApplication] statusBarOrientation];
	if ([ori isEqualToString:@"portrait"]) {
		if (currentOri == UIInterfaceOrientationLandscapeLeft || currentOri == UIInterfaceOrientationLandscapeRight) {
			NSLog(@"change to portrait");
			//[[UIApplication sharedApplication] setStatusBarHidden:YES];
			if ( CGAffineTransformIsIdentity(self.webView.transform)) {
				self.webView.transform = CGAffineTransformIdentity;
				//the app starts with lanscape
				if (currentOri == UIInterfaceOrientationLandscapeLeft) {
					self.webView.transform = CGAffineTransformMakeRotation(degreesToRadian(90));
				} else if (currentOri == UIInterfaceOrientationLandscapeRight) {
					self.webView.transform = CGAffineTransformMakeRotation(degreesToRadian(-90));
				}
			} else {
				//the app has been rotated, change it back
				self.webView.transform = CGAffineTransformIdentity;
			}
			CGRect screenBounds = [ [ UIScreen mainScreen ] bounds ];
			self.webView.bounds = CGRectMake(0.0, 0.0, screenBounds.size.width, screenBounds.size.height);
			self.webView.center = CGPointMake(screenBounds.size.width/2, screenBounds.size.height/2);
			[[UIApplication sharedApplication] setStatusBarOrientation:UIInterfaceOrientationPortrait];
			[self.webView stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"window.plugins.deviceOrientation.success('%s');", "portrait"]];
		}
	} else if ([ori isEqualToString:@"landscape"]) {
		if (currentOri == UIInterfaceOrientationPortrait || currentOri == UIInterfaceOrientationPortraitUpsideDown) {
			NSLog(@"change to landscape");
			//[[UIApplication sharedApplication] setStatusBarHidden:YES];
			if (CGAffineTransformIsIdentity(self.webView.transform)) {
				self.webView.transform = CGAffineTransformIdentity;
				//the app starts with portrait view
				if (currentOri == UIInterfaceOrientationPortrait) {
					self.webView.transform = CGAffineTransformMakeRotation(degreesToRadian(-90));
				} else if (currentOri == UIInterfaceOrientationPortraitUpsideDown) {
					self.webView.transform = CGAffineTransformMakeRotation(degreesToRadian(90));
				}
			} else {
				self.webView.transform = CGAffineTransformIdentity;
			}
			CGRect screenBounds = [ [ UIScreen mainScreen ] bounds ];
			self.webView.bounds = CGRectMake(0.0, 0.0, screenBounds.size.height, screenBounds.size.width);
			if (statusBarHidden) {
				self.webView.center = CGPointMake(screenBounds.size.width/2, screenBounds.size.height/2);
			} else {
				CGFloat statusBarHeight = [UIApplication sharedApplication].statusBarFrame.size.height;
				self.webView.center = CGPointMake(screenBounds.size.width/2 + statusBarHeight, screenBounds.size.height/2 - statusBarHeight);
			}
			[[UIApplication sharedApplication] setStatusBarOrientation:UIInterfaceOrientationLandscapeLeft];
			[self.webView stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"window.plugins.deviceOrientation.success('%s');", "landscape"]];
		}
	}
}

@end
