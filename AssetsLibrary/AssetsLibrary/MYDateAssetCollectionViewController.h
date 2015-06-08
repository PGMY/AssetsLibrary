//
//  MYDateAssetCollectionViewController.h
//  AssetsLibrary
//
//  Created by PGMY on 2014/02/12.
//  Copyright (c) 2014年 MikaYamamoto. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MYDateAssetCollectionViewController : UICollectionViewController {
    NSMutableArray *sectionList_;
    NSMutableDictionary *assetsData_;
}

@property (strong, nonatomic) NSMutableArray *sectionList;
@property (strong, nonatomic) NSMutableDictionary *assetsData;

@end
