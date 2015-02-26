//
//
//  Created by AnujKosambi on 23/02/15.
//  Copyright (c) 2015 AnujKosambi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface CollectionAlbumLayout : UICollectionViewLayout <UICollectionViewDelegateFlowLayout>

@property (nonatomic) CGPoint gesturePoint;
@property (nonatomic) NSIndexPath *selectedItem;
@property (nonatomic) NSIndexPath *hoverItem;

@end
