import SwiftUI

struct SOSAlertView: View {
    @State private var showSOSAlert = false

    var body: some View {
        VStack {
            Spacer()
            
            Button(action: {
                showSOSAlert = true
            }) {
                HStack {
                    Image(systemName: "exclamationmark.triangle.fill")
                    Text("SOS Alert").bold()
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.red)
                .foregroundColor(.white)
                .cornerRadius(10)
                .padding()
            }
            .alert(isPresented: $showSOSAlert) {
                Alert(
                    title: Text("SOS Activated!"),
                    message: Text("Emergency services have been notified."),
                    dismissButton: .default(Text("OK"))
                )
            }
            
            Spacer()
        }
    }
}

struct SOSAlertView_Previews: PreviewProvider {
    static var previews: some View {
        SOSAlertView()
    }
}
