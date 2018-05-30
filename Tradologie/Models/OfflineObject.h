//
//  OfflineObject.h
//  UrbanRunr
//
//  Created by Chandresh Maurya on 15/05/18.
//  Copyright © 2018 Chandresh Maurya. All rights reserved.
//


#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface OfflineObject : NSManagedObject

@property (nonatomic, retain) NSNumber  *objId;
@property (nonatomic, retain) NSString  *objName;
@property (nonatomic, retain) NSString  *objData;
@property (nonatomic, retain) NSNumber  *objType;
@property (nonatomic, retain) NSString  *objClass;
@property (nonatomic, retain) NSNumber  *isOfflineUpdated;



@end
