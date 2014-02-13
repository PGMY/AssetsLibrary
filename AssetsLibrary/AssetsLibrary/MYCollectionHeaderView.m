//
//  MYCollectionHeaderView.m
//  AssetsLibrary
//
//  Created by Mika Yamamoto on 2014/02/13.
//  Copyright (c) 2014年 MikaYamamoto. All rights reserved.
//

#import "MYCollectionHeaderView.h"

@implementation MYCollectionHeaderView

@synthesize title = title_;

- (void)dealloc {
    [self.title release];
    [super dealloc];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        UILabel *l = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, frame.size.width-20, frame.size.height)];
        self.title = l;
        [l release];
        [self.title setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.5]];
        [self addSubview:self.title];
    }
    return self;
}

@end
