//
//  MYAssetsGroupViewController.h
//  AssetsLibrary
//
//  Created by PGMY on 2014/02/12.
//  Copyright (c) 2014年 PGMY. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MYAssetsGroupViewController : UITableViewController {
    NSMutableArray *assetsGroups_;
}

@property (strong, nonatomic) NSMutableArray *assetsGroups;

@end
