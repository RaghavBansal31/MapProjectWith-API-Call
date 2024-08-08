//
//  SecondScreen.swift
//  MapProject
//
//  Created by Consultant on 8/3/23.
//

import SwiftUI

import CoreLocation

struct SecondScreen: View {
    let mod:MapModel
    @State var loading:Bool = true
    var body: some View {
        
        VStack{

//            Text(mod.name)
//            Text(mod.email)
//            Text(mod.phone)
//            Text(mod.username)
//            Text(mod.website)
            
            Text(mod.address.city)
            Text(mod.address.street)
            Text(mod.address.suite)
            Text(mod.address.suite)
            Text(mod.address.zipcode)
            Text(mod.address.geo.lat.description)
            Text(mod.address.geo.lng.description)
            Text(mod.company.bs)
            Text(mod.company.catchPhrase)
            Text(mod.company.name)
        }
        .font(.headline).foregroundColor(.pink)
        .background(Color.black).cornerRadius(10)
        
        .redacted(reason: loading ? .placeholder: [])
            .onAppear(){
                Task{
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2){
                        loading = false
                    }
                }
            }
    }
}

struct SecondScreen_Previews: PreviewProvider {
    static var previews: some View {
        SecondScreen(mod: MapModel(id: 0, name: "", username: "", email: "", address: Address(street: "", suite: "", city: "", zipcode: "", geo: Geo(lat: "", lng: "")), phone: "", website: "", company: Company(name: "", catchPhrase: "", bs: "")))
    }
}
