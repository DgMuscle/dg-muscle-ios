import SwiftUI
import SDWebImageSwiftUI

struct LegCurlInfoView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                Text("Leg curl")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(.largeTitle)
                
                Text("The leg curl is an isolation exercise that targets the hamstring muscles. The exercise involves flexing the lower leg against resistance towards the buttocks. There are three types of leg curls. There are seated leg curls, lying leg curls, and standing leg curls.\n\nOther exercises that can be used to strengthen the hamstrings include the glute-ham raise and the deadlift.")
                    .padding()
                
                AnimatedImage(name: "leg_curl.gif")
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
    LegCurlInfoView()
}
