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
        self.layer.borderWidth = 3;
        self.layer.borderColor = [UIColor redColor].CGColor;
        
    }
    return self;
}

@end
