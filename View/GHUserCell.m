//
//  GHUserCell.m
//  RestKit Tutorial
//
//  Created by Alexis Kinsella on 09/25/12
//  Copyright (c) 2012 Xebia France. All rights reserved.
//

#import "GHUserCell.h"
#import <QUartzCore/QuartzCore.h>

@implementation GHUserCell

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.imageView.frame = CGRectMake(10,10,44,44);
    self.imageView.layer.masksToBounds = YES;
    self.imageView.layer.cornerRadius = 3.0;
}

@end
