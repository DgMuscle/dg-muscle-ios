import SwiftUI

struct PullUpInfoView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                Text("Pull Up")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(.largeTitle)
                
                Text("A pull-up is an upper-body strength exercise. The pull-up is a closed-chain movement where the body is suspended by the hands, gripping a bar or other implement at a distance typically wider than shoulder-width, and pulled up. As this happens, the elbows flex and the shoulders adduct and extend to bring the elbows to the torso.\n\nPull-ups build up several muscles of the upper body, including the latissimus dorsi, trapezius, and biceps brachii. A pull-up may be performed with overhand (pronated), underhand (supinated)—sometimes referred to as a chin-up—neutral, or rotating hand position.")
                    .padding()
                
                Image("pullup", bundle: nil)
                    .resizable()
                    .scaledToFit()
                    .padding()
                    .background { RoundedRectangle(cornerRadius: 8) }
                    .padding()
                
                Spacer(minLength: 100)
            }
            .padding()
        }
        .scrollIndicators(.hidden)
        .preferredColorScheme(.dark)
    }
}

#Preview {
    PullUpInfoView()
}
