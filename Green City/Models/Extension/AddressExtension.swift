//
//  AddressExtension.swift
//  Green City
//
//  Created by Bogdan Ilic on 8/24/18.
//  Copyright © 2018 Bogdan Ilic. All rights reserved.
//
extension Address
{
    func fullAddress() -> String
    {
        if street != nil
        {
            return street! + ", " + city + ", " + country
        }
        else
        {
            return city + ", " + country
        }
    }
    
}
