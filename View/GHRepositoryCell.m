//
//  GHRepositoryCell.m
//  RestKit Tutorial
//
//  Created by Alexis Kinsella on 09/25/12
//  Copyright (c) 2012 Xebia France. All rights reserved.
//

#import "GHRepositoryCell.h"
#import "QuartzCore/QuartzCore.h"

@implementation GHRepositoryCell

- (void)layoutSubviews {
    [super layoutSubviews];
    self.imageView.frame = CGRectMake(10,9,44,44);
    self.imageView.layer.masksToBounds = YES;
    self.imageView.layer.cornerRadius = 3.0;
}

@end
