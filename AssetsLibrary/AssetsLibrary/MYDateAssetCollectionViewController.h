//
//  MYDateAssetCollectionViewController.h
//  AssetsLibrary
//
//  Created by Mika Yamamoto on 2014/02/12.
//  Copyright (c) 2014年 MikaYamamoto. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MYDateAssetCollectionViewController : UICollectionViewController {
    NSMutableArray *allAssets_;
    NSMutableArray *assetsSection_;
}

@property (strong, nonatomic) NSMutableArray *allAssets;
@property (strong, nonatomic) NSMutableArray *assetsSection;

@end
