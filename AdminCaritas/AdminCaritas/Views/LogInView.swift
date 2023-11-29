import SwiftUI


struct LogInView: View {
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var isSecured: Bool = true
    @State var administrador: Administrador
    @State private var isAuthenticate: Bool = false
    @State var isPresented: Bool = false
    @State private var opacity = 0.5
    
    var body: some View {
        NavigationStack{
            VStack {
                Spacer()
                
                Image("Logo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 200)
                    .padding(.bottom, 20)
                ZStack{
                    Rectangle()
                        .foregroundColor(Color("PantoneAC"))
                        .frame(width: 333, height: 45)
                        .cornerRadius(5)
                    
                    TextField("Matrícula o Usuario", text: $username)
                        .frame(width: 300, height: 45)
                        .foregroundColor(.white)
                        .background(Color("PantoneAC"))
                        .border(Color("PantoneAC"), width: 2)
                        .cornerRadius(5)
                        .padding(.horizontal, 30)
                }
                
                if isSecured{
                    ZStack{
                        Rectangle()
                            .foregroundColor(Color("PantoneAC"))
                            .frame(width: 333, height: 45)
                            .cornerRadius(5)
                        
                        SecureField("Contraseña", text: $password) // Usar SecureField para contraseñas
                            .frame(width: 310, height: 45)
                            .foregroundColor(.white)
                            .background(Color("PantoneAC"))
                            .border(Color("PantoneAC"), width: 2)
                            .cornerRadius(5)
                            .padding(.horizontal, 30)
                        
                        HStack{
                            Spacer()
                            Button(action: {
                                isSecured = false
                            }) {
                                Image(systemName: "eye.slash")
                                    .foregroundColor(.white)
                            }
                            .frame(alignment: .leading)
                        }
                        .frame(width: 310)
                        
                    }
                }
                else{
                    ZStack{
                        Rectangle()
                            .foregroundColor(Color("PantoneAC"))
                            .frame(width: 333, height: 45)
                            .cornerRadius(5)
                        
                        TextField("Contraseña", text: $password) // Usar SecureField para contraseñas
                            .frame(width: 310, height: 45)
                            .foregroundColor(.white)
                            .background(Color("PantoneAC"))
                            .border(Color("PantoneAC"), width: 2)
                            .cornerRadius(5)
                            .padding(.horizontal, 30)
                        
                        HStack{
                            Spacer()
                            Button(action: {
                                isSecured = true
                            }) {
                                Image(systemName: "eye")
                                    .foregroundColor(.white)
                            }
                            .frame(alignment: .leading)
                        }
                        .frame(width: 310)
                        
                    }
                }
                HStack {
                    Spacer()
                    Button("¿Olvidaste tu contraseña?") {
                        
                    }
                    .font(.footnote)
                    .foregroundColor(Color("PantoneAO"))
                    .padding(.horizontal, 30)
                    .padding(.top, 5)
                    .padding(.bottom, 15)
                }
                Button(action: {
                    signIn()
                }){
                    ZStack{
                        Rectangle()
                            .foregroundColor(.clear)
                            .background(Color("PantoneAO"))
                            .cornerRadius(5)
                            .frame(width: 320, height: 45)
                            .shadow(color: .black.opacity(0.25), radius: 2, x: 0, y: 4)
                        
                        Text("Iniciar Sesión")
                            .foregroundColor(.white)
                    }
                }
                .alert(isPresented: $isPresented, content: {
                    Alert(title: Text("Credenciales Incorrectas"), message: Text("Inicio de sesión fallido. Verifica tus credenciales."),primaryButton: .default(Text("Aceptar")), secondaryButton: .destructive(Text("Cancelar")))})
                
                NavigationLink(isActive: $isAuthenticate, destination: { ContentView(administrador: administrador) }, label: { EmptyView()})
                
                Spacer()
                Spacer()
            }
        }
    }

    func signIn() {
        let user = User(username: username, password: password)
        administrador = VerificarUsuario(usr: user)

        if administrador.idRecolector != 0 {
            isAuthenticate = true
        } else {
            isPresented = true
        }
    }

}

struct LogInView_Previews: PreviewProvider {
    static var previews: some View {
        LogInView(administrador: Administrador(access_token: "", token_type: "", idRecolector: 1))
    }
}
