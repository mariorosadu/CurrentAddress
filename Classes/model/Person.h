//
//  Person.h
//  CurrentAddress
//
//  Created by Mario Souza on 3/6/13.
//
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>



@interface Person : NSObject

@property (strong, nonatomic) NSString *name;
@property (nonatomic) CLLocationCoordinate2D coordenadas;
@property (strong, nonatomic) NSString *timestamp;

//- (void)setPersonName: (NSString *) Name: (NSString) name;


@end
