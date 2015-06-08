//
//  MYCollectionHeaderView.m
//  AssetsLibrary
//
//  Created by PGMY on 2014/02/13.
//  Copyright (c) 2014年 MikaYamamoto. All rights reserved.
//

#import "MYCollectionHeaderView.h"

@implementation MYCollectionHeaderView

@synthesize title = title_;

- (void)dealloc
{
    [self.title release];
    [super dealloc];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UILabel *l = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, frame.size.width - 10, frame.size.height)];
        self.title = l;
        [l release];
        [self addSubview:self.title];
    }
    
    return self;
}

@end
