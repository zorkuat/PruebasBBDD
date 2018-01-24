//
//  BaseDatos.h
//  PruebasBBDD
//
//  Created by cice on 24/1/18.
//  Copyright © 2018 TATINC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface BaseDatos : NSObject

+ (BaseDatos*)instancia;

-(void) cargarBaseDatos;
-(NSManagedObjectContext *) moc;

@end
