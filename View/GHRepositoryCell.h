//
//  GHRepositoryCell.h
//  RestKit Tutorial
//
//  Created by Alexis Kinsella on 09/25/12
//  Copyright (c) 2012 Xebia France. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GHRepositoryCell.h"

@interface GHRepositoryCell : UITableViewCell

@property (nonatomic, strong) IBOutlet UILabel *titleLabel;
@property (nonatomic, strong) IBOutlet UILabel *descriptionLabel;

@end
