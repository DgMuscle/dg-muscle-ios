import SwiftUI
import SDWebImageSwiftUI

struct PushUpInfoView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                Text("Push up")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(.largeTitle)
                
                Text("The push-up (press-up in British English) is a common calisthenics exercise beginning from the prone position. By raising and lowering the body using the arms, push-ups exercise the pectoral muscles, triceps, and anterior deltoids, with ancillary benefits to the rest of the deltoids, serratus anterior, coracobrachialis and the midsection as a whole.[1] Push-ups are a basic exercise used in civilian athletic training or physical education and commonly in military physical training. They are also a common form of punishment used in the military, school sport, and some martial arts disciplines. Variations of push-ups, such as wide-arm push-ups, diamond push-ups target specific muscle groups and provide further challenges.")
                    .padding()
                
                AnimatedImage(name: "push_up.gif")
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
    PushUpInfoView()
}
