import SwiftUI
import SDWebImageSwiftUI

struct LegPressInfoView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                Text("Leg press")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(.largeTitle)
                
                Text("The leg press is a compound weight training exercise in which the individual pushes a weight or resistance away from them using their legs. The term leg press machine refers to the apparatus used to perform this exercise. The leg press can be used to evaluate an athlete's overall lower body strength (from the gluteus Maximus to the lower leg muscles). It can help to build squat strength. If performed correctly, the inclined leg press can help develop knees to manage heavier free weights, on the other hand, it has the potential to inflict grave injury: the knees could bend the wrong way if they are locked during the exercise.")
                    .padding()
                
                AnimatedImage(name: "leg_press.gif")
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
    LegPressInfoView()
}
