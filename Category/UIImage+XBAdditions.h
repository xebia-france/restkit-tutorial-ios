//
//  UIImage+WPAdditions.h
//  RestKit Tutorial
//
//  Created by Alexis Kinsella on 20/09/12.
//  Copyright (c) 2012 Xebia France. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (WPAdditions)

-(UIImage*) centerImage:(UIImage *)inImage inRect:(CGRect) thumbRect;

- (UIImage*)imageScaledToSize:(CGSize)size;

+(UIImage *)scale:(UIImage *)image toSize:(CGSize)size;

@end
