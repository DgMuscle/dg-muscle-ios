import SwiftUI
import SDWebImageSwiftUI

struct TricepPushDownInfoView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                Text("Tricep pushdown")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(.largeTitle)
                
                Text("""
                     As you prepare for this move, face the tricep pushdown cable machine and grasp the horizontal cable bar or rope attachment (depending on the machine your gym has) with an overhand grip.1 Adjust the bar or rope grips to about chest level.
                     
                     Use the pin-and-place adjustment and set a low weight to start. Different versions of the machine may include other weighting mechanisms.

                        1. Start by bracing your abdominals.\n
                        2. Tuck your elbows in at your sides and position your feet slightly apart.1\n
                        3. Inhale. Push down until your elbows are fully extended but not yet in the straight, locked position. Keep your elbows close to your body and bend your knees slightly on the pushdown. Resist bending forward. Try to keep your back as straight as possible as you push down.1\n
                        4. As you exhale, return to the starting point using a controlled movement. Try not to crash the weights.\n
                    
                     For beginners, aim to complete 4 sets of 8 reps. As you gain fitness, you can increase the number of reps you do and the amount of weight you use as resistance.
                    """)
                    .padding()
                
                Image("tricep_pushdown", bundle: nil)
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
    TricepPushDownInfoView()
}
