//
//  Disco+CoreDataProperties.m
//  PruebasBBDD
//
//  Created by cice on 24/1/18.
//  Copyright © 2018 TATINC. All rights reserved.
//
//

#import "Disco+CoreDataProperties.h"

@implementation Disco (CoreDataProperties)

+ (NSFetchRequest<Disco *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"Disco"];
}

@dynamic titulo;
@dynamic anno;
@dynamic genero;
@dynamic publicadoPor;

@end
