//
//  UIScreen+XBAdditions.m
//  RestKit Tutorial
//
//  Created by Alexis Kinsella on 30/09/12.
//  Copyright (c) 2012 Xebia France. All rights reserved.
//

#import "UIScreen+XBAdditions.h"

@implementation UIScreen (XBAdditions)

+(CGRect)getScreenBoundsForCurrentOrientation {
    return [self getScreenBoundsForOrientation:[UIApplication sharedApplication].statusBarOrientation];
}

+(CGRect)getScreenBoundsForOrientation:(UIInterfaceOrientation)orientation {
    
    UIScreen *screen = [UIScreen mainScreen];
    CGRect fullScreenRect = screen.bounds; //implicitly in Portrait orientation.
    
    if(orientation == UIInterfaceOrientationLandscapeRight || orientation ==  UIInterfaceOrientationLandscapeLeft){
        CGRect temp = CGRectZero;
        temp.size.width = fullScreenRect.size.height;
        temp.size.height = fullScreenRect.size.width;
        fullScreenRect = temp;
    }
    
    return fullScreenRect;
}

@end
