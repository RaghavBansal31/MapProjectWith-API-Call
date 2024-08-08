//
//  PlaceMarker.swift
//  MapProject
//
//  Created by Consultant on 8/2/23.
//

import SwiftUI

struct PlaceMarker: View {
    let title:String
    var body: some View {
        VStack{
            Text(title).font(.title)
                .background(Color.red).cornerRadius(10)
            
            Image(systemName: "mappin.and.ellipse")
                .font(.title)
                .foregroundColor(Color.red)
            
        }
    }
}

struct PlaceMarker_Previews: PreviewProvider {
    static var previews: some View {
        PlaceMarker(title: "London")
    }
}
