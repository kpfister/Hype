//
//  DateHelper.swift
//  Hype
//
//  Created by Karl Pfister on 7/5/16.
//  Copyright © 2016 Karl Pfister. All rights reserved.
//

import Foundation

extension NSDate {
    func stringValue() -> String {
        let formatter = NSDateFormatter()
        formatter.dateFormat = "M:d:yyyy - hh:mm:ss a"
        return formatter.stringFromDate(self)
    }
}


/*
 //////////////// YEARS ////////////////////////
 
 "y"    A year with at least 1 digit.
 
 "yy" A year with exactly 2 digits. If less, it is padded with a zero. It will be truncated to the tens digit if larger.
 
 "yyy" A year with at least 3 digits. If less, it is padded with zeros.
 
 "yyyy" A year with at least 3 digits. If less, it is padded with zeros.
 
 //////////////// MONTHS ////////////////////////
 
 "M"    A month with at least 1 digit. July → "7"
 
 "MM" A month with at least 2 digits. If less, it is padded with zeros. July → "07"
 
 "MMM"    Three letter month abbreviation. July → "Jul"
 
 "MMMM"    Full name of month. July → "July"
 
 "MMMMM" One letter month abbreviation. Not unique, January, June, and July are all "J". December → "D"
 
 //////////////// DAYS ////////////////////////
 
 "d"    A day with at least 1 digit. 4 → "4"  25 → "25"
 
 "dd" A day with at least 2 digits. If less, it is padded with a zero. 4 → "04"
 
 "E", "EE", or"EEE"    3 letter day abbreviation of day name. Wednesday → "Wed"
 
 "EEEE"    Full day name. Wednesday → "Wednesday"  Thursday → "Thursday"
 
 "EEEEE" 1 letter day abbreviation of day name. Not unique, Tuesday and Thursday are both "T".  Wednesday → "W"
 
 "EEEEEE"    2 letter day abbreviation of day name. Wednesday → "We"  Thursday → "Th"
 
 //////////////// HOURS ////////////////////////
 
 "a"    Period of day (AM/PM). 5 PM → "PM"  7 AM → "AM"
 
 "h"    A 1-12 based hour with at least 1 digit. 5 PM → "5"  7 AM → "7"
 
 "hh" A 1-12 based hour with at least 2 digits. If less, it is padded with a zero. 5 PM → "05"  7 AM → "07"
 
 "H"    A 0-23 based hour with at least 1 digit. 5 PM → "17"  7 AM → "7"
 
 "HH" A 0-23 based hour with at least 2 digits. If less, it is padded with a zero. 5 PM → "17"  7 AM → "07"
 
 //////////////// MINUTES ////////////////////////
 
 "m"    A minute with at least 1 digit.  40 → "40"  1 → "1"
 
 "mm" A minute with at least 2 digits.  If less, it is padded with a zero.  40 → "40"  1 → "01"
 
 //////////////// SECONDS ////////////////////////
 
 "s"    A second with at least 1 digit. 40 → "40"  1 → "1"
 
 "ss" A second with at least 2 digits. If less, it is padded with a zero. 40 → "40"  1 → "01"
 
 "S"    Tenths place of fractional second. 123 ms → "1"   7 ms → "0"
 
 "SS" Tenths and hundredths place of a fractional second.  123 ms → "12"  7 ms → "00"
 
 "SSS" Tenths, hundredths, and thousandths place of a fractional second. 123 ms → "123"  7 ms → "007"
 
 */