//
//  MovieVO.swift
//  MyMovieChart
//
//  Created by KimHyo kook on 2016. 3. 21..
//  Copyright © 2016년 Hyokook KIM. All rights reserved.
//

import Foundation
import UIKit


class AssemblymanVO{
    
    init(){
        
    }
    
    var thumbnail : String? /*이미지 주소*/
    
    var Kname : String? /*한글 이름*/
    
    var Cname : String? /*한자 이름*/
    
    var Ename : String? /*영어 이름*/
    
    var origNm : String? /*선거구*/
    
    var detail : String? /*약력*/
    
    var reeleGbNm : String? /*당선 횟수*/
    
    var deptCD : String? /*부서 코드*/
    
    var rating : Float?
    
    var thumnailImage : UIImage? /*이미지 데이터*/
}
