import SwiftUI

struct DeadliftInfoView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                Text("Deadlift")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(.largeTitle)
                
                Text("The deadlift exercise is a relatively simple exercise to perform, a weight is lifted from a resting position on the floor to an upright position. The deadlift exercise utilizes multiple muscle groups to perform but has been used to strength the hips, thighs, and back musculature.")
                    .padding()
                
                Image("deadlift", bundle: nil)
                    .resizable()
                    .scaledToFit()
                    .padding()
                    .background { RoundedRectangle(cornerRadius: 8) }
                    .padding()
                
                Text("1. Start with the feet shoulder width apart (foot stance may vary depending on variation). Feet are under the bar with the bar close to the shins")
                
                Spacer(minLength: 20)
                
                Text("2. Lower the torso to the bar by pushing the buttocks back and hinging at the waist. Then grasp the bar in your hands.")
                
                Spacer(minLength: 20)
                
                Text("3. Squeeze the shoulder blades together to engage the lats, followed by engaging the core musculature. Make sure to keep the hips lower than the shoulders and the head/neck in a neutral position.")
                
                Spacer(minLength: 20)
                
                Text("4. Push through the feet and pull the weight up. Think about pushing the floor away, rather than lifting the weight up. The bar should stay relatively close to the shins. Squeeze the glutes to lock the top of the lift.")
                
                Spacer(minLength: 20)
                
                Text("5. Lower to the floor the the reverse manner.")
                
                Spacer(minLength: 100)
            }
            .padding()
        }
        .scrollIndicators(.hidden)
        .preferredColorScheme(.dark)
    }
}

#Preview {
    DeadliftInfoView()
}

