import SwiftUI
import SDWebImageSwiftUI

struct LegExtensionInfoView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                Text("Leg extension")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(.largeTitle)
                
                Text("The leg extension is a resistance weight training exercise that targets the quadriceps muscle (m. quadriceps femoris) in the legs. The exercise is done using a machine called the Leg Extension Machine. There are various manufacturers of these machines and each one is slightly different. Most gym and weight rooms will have the machine in their facility. The leg extension is an isolated exercise targeting one specific muscle group, the quadriceps. It should not be considered as a total leg workout, such as the squat or deadlift.[citation needed]")
                    .padding()
                
                Text("The exercise consists of bending the leg at the knee and extending the legs, then lowering them back to the original position.")
                    .padding()
                
                AnimatedImage(name: "leg_extension.gif")
                    .resizable()
                    .frame(height: 300)
                    .clipShape(.rect(cornerRadii: .init(topLeading: 8, bottomLeading: 8, bottomTrailing: 8, topTrailing: 8)))
                
                Spacer(minLength: 100)
            }
            .padding()
        }
        .scrollIndicators(.hidden)
        .preferredColorScheme(.dark)
    }
}

#Preview {
    LegExtensionInfoView()
}

