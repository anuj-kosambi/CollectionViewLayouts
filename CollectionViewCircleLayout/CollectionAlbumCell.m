//
//  CollectionCircleCell.m
//
//  Created by AnujKosambi on 23/02/15.
//  Copyright (c) 2015 AnujKosambi. All rights reserved.
//

#import "CollectionAlbumCell.h"

@implementation CollectionAlbumCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];

    if (self) {
        self.imageView = [[UIImageView alloc] initWithFrame:self.bounds];
        self.imageView.layer.shouldRasterize = YES;
        self.imageView.layer.opaque = YES;
        [self.contentView setBackgroundColor:[UIColor clearColor]];
        [self.contentView addSubview:self.imageView];
    }
    return self;
}

- (void)layoutSubviews {
    self.bounds = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    self.imageView.frame = self.bounds;
    self.imageView.layer.borderWidth = 5;
    self.imageView.layer.borderColor = [UIColor whiteColor].CGColor;
    self.imageView.alpha = 1;
//    self.layer.shadowColor = [UIColor blackColor].CGColor;
//    self.layer.shadowOpacity = 1;
    self.layer.zPosition = 1;
}

- (void)prepareForReuse {
    self.imageView.image = nil;
    self.imageView.layer.borderWidth = 5;
    [self.contentView setBackgroundColor:[UIColor clearColor]];
}

@end
