//
//  GHRepositoryTableViewController.m
//  RestKit Tutorial
//
//  Created by Alexis Kinsella on 09/25/12.
//  Copyright (c) 2012 Xebia France. All rights reserved.
//

#import <RestKit/RestKit.h>
#import <RestKit/UI.h>
#import "GHRepository.h"
#import "GHRepositoryTableViewController.h"
#import "SDImageCache.h"
#import "SDWebImageManager.h"
#import "GHRepositoryCell.h"
#import "UIImageView+WebCache.h"
#import "UIColor+XBAdditions.h"
#import "UIScreen+XBAdditions.h"

#define FONT_SIZE 13.0f
#define CELL_BORDER_WIDTH 88.0f // 320.0f - 232.0f
#define CELL_MIN_HEIGHT 64.0f
#define CELL_BASE_HEIGHT 48.0f
#define CELL_MAX_HEIGHT 1000.0f

@interface GHRepositoryTableViewController ()
@property (nonatomic, strong) RKTableController *tableController;
@property (nonatomic, strong) UIImage* defaultAvatarImage;
@end

@implementation GHRepositoryTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configure];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.tableController loadTableFromResourcePath:@"/orgs/xebia-france/repos?per_page=100"];
}

- (void)configure {
    self.defaultAvatarImage = [UIImage imageNamed:@"github-gravatar-placeholder"];
    [self configureTableViews];
    [self configureTableController];
}

- (void)configureTableViews {
    [self configureTableView];
    [self configurePullToRefreshTriggerView];
}


- (void)configureTableView {
    self.tableView.backgroundColor = [UIColor colorWithPatternImageName:@"bg_home_pattern"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;

    [self.tableView registerNib:[UINib nibWithNibName:@"GHRepositoryCell" bundle:nil] forCellReuseIdentifier:@"GHRepository"];
}

- (void)configurePullToRefreshTriggerView {
    NSBundle *restKitResources = [NSBundle restKitResourcesBundle];
    UIImage *arrowImage = [restKitResources imageWithContentsOfResource:@"blueArrow" withExtension:@"png"];
    [[RKRefreshTriggerView appearance] setTitleFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:13]];
    [[RKRefreshTriggerView appearance] setLastUpdatedFont:[UIFont fontWithName:@"HelveticaNeue" size:11]];
    [[RKRefreshTriggerView appearance] setArrowImage:arrowImage];
}

- (void)configureTableController {
    self.tableController = [[RKObjectManager sharedManager] tableControllerForTableViewController:self];
    
    self.tableController.delegate = self;
    
    self.tableController.pullToRefreshEnabled = YES;
    self.tableController.variableHeightRows = YES;
    
    self.tableController.imageForOffline = [UIImage imageNamed:@"offline.png"];
    self.tableController.imageForError = [UIImage imageNamed:@"error.png"];
    self.tableController.imageForEmpty = [UIImage imageNamed:@"empty.png"];
    
    [self.tableController mapObjectsWithClass:[GHRepository class] toTableCellsWithMapping:[self createCellMapping]];
}

- (RKTableViewCellMapping *)createCellMapping {
    RKTableViewCellMapping *cellMapping = [RKTableViewCellMapping cellMapping];
    cellMapping.cellClassName = @"GHRepositoryCell";
    cellMapping.reuseIdentifier = @"GHRepository";

    cellMapping.heightOfCellForObjectAtIndexPath = ^ CGFloat(GHRepository *repository, NSIndexPath* indexPath) {
        CGRect bounds = [UIScreen getScreenBoundsForCurrentOrientation];
        CGSize constraint = CGSizeMake(bounds.size.width - CELL_BORDER_WIDTH, CELL_MAX_HEIGHT);
        CGSize size = [repository.description_ sizeWithFont:[UIFont systemFontOfSize:FONT_SIZE]
                                          constrainedToSize:constraint
                                              lineBreakMode:UILineBreakModeWordWrap];
        CGFloat height = MAX(CELL_BASE_HEIGHT + size.height, CELL_MIN_HEIGHT);
        
        return height;
    };

    [cellMapping mapKeyPath:@"name" toAttribute:@"titleLabel.text"];
    [cellMapping mapKeyPath:@"description_" toAttribute:@"descriptionLabel.text"];

    return cellMapping;
}

- (void)tableController:(RKAbstractTableController *)tableController willDisplayCell:(UITableViewCell *)cell forObject:(id)object atIndexPath:(NSIndexPath *)indexPath {
    GHRepository *repository = object;
    GHRepositoryCell *repositoryCell = (GHRepositoryCell *)cell;
    [repositoryCell.imageView setImageWithURL:[repository.owner avatarImageUrl] placeholderImage:self.defaultAvatarImage];
}

@end