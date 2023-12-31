import SwiftUI
import SDWebImageSwiftUI

struct BicepCurlInfoView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                Text("Bicep curl")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(.largeTitle)
                
                Text("Bicep curls are a group of weight training exercises in which a person bends their arm towards their body at the elbow in order to make their biceps stronger.")
                    .padding()
                
                Text("The bicep curl mainly targets the biceps brachii, brachialis and brachioradialis muscles. The biceps is stronger at elbow flexion when the forearm is supinated (palms turned upward) and weaker when the forearm is pronated. The brachioradialis is at its most effective when the palms are facing inward, and the brachialis is unaffected by forearm rotation. Therefore, the degree of forearm rotation affects the degree of muscle recruitment between the three muscles.")
                    .padding()
                
                AnimatedImage(name: "bicep_curl.gif")
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
    BicepCurlInfoView()
}
