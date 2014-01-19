//
//  Orientation.h
//  PhoneGapLib
//
//  Created by Wei Li on 11/10/2011.
//  Copyright 2011 FeedHenry. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Cordova/CDVPlugin.h>


@interface Orientation : CDVPlugin {

}

- (void) setOrientation:(CDVInvokedUrlCommand*) command;

@end
