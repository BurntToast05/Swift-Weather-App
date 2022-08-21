//
//  DetailedInfoGridItem.swift
//  Swift-Learning-App
//
//  Created by Corbin Gollaher on 8/20/22.
//

import SwiftUI

struct DetailedInfoGridItem: View {
    var titleText: String
    var valueText: String
    var titleText2: String
    var valueText2: String

    var body: some View {
        HStack {
            VStack {
                Text(titleText).foregroundColor(Color.white).fontWeight(.semibold)
                Text(valueText).foregroundColor(Color.white)
                    .fontWeight(.semibold).frame(maxWidth: .infinity)
            }
            VStack {
                Text(titleText2).foregroundColor(Color.white).fontWeight(.semibold)
                Text(valueText2).foregroundColor(Color.white)
                    .fontWeight(.semibold).frame(maxWidth: .infinity)
            }
        }.padding(2)
        Divider().background(Color.white)
    }
}

struct DetailedInfoGridItem_Previews: PreviewProvider {
    static var previews: some View {
        DetailedInfoGridItem(titleText: "Key", valueText: "Value", titleText2: "Key", valueText2: "Value")
    }
}
