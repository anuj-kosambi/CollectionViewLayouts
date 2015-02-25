//
//  CollectionDataSource.h
//
//  Created by AnujKosambi on 23/02/15.
//  Copyright (c) 2015 AnujKosambi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "CollectionAlbumCell.h"
#import "CollectionSupplementaryView.h"

@interface CollectionDataSource: NSObject <UICollectionViewDataSource>

- (instancetype)initWithDataSource:(NSMutableDictionary *)dicitonary;


@end
