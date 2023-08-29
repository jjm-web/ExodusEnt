//
//  SignUpViewController.swift
//  ExodusEnt
//
//  Created by 장준명 on 2022/09/06.
//

import UIKit
import KakaoSDKAuth
import KakaoSDKUser
import AuthenticationServices
import GoogleSignIn
import Firebase
import FirebaseCore
import FirebaseAuth
import FirebaseDatabase
import CryptoKit

class SignUpViewController: UIViewController {
   
    var emailData : String!
    var passwordData : String!
    var currentNonce: String?
    var ref: DatabaseReference!
   
    @IBOutlet var KakaoLogin: UIButton!
    @IBOutlet var appleLogin: ASAuthorizationAppleIDButton!
    @IBOutlet var googleLogin: GIDSignInButton!
    @IBOutlet var noLoginEnter: UIButton!
   
    @IBAction func appleLoginBtn(_ sender: UIButton) {
        startSignInWithAppleFlow()
    }
    
    @IBAction func googleLoginBtn(_ sender: GIDSignInButton) {
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }

           // Create Google Sign In configuration object.
           let config = GIDConfiguration(clientID: clientID)
           GIDSignIn.sharedInstance.configuration = config

           // Start the sign in flow!
           GIDSignIn.sharedInstance.signIn(withPresenting: self) { [unowned self] result, error in
               guard error == nil else {
                   // Handle sign in error...
                   return
               }

               guard let user = result?.user,
                   let idToken = user.idToken?.tokenString
               else {
                   // Handle missing user or idToken...
                   return
               }

               let credential = GoogleAuthProvider.credential(withIDToken: idToken,
                                                              accessToken: user.accessToken.tokenString)

               Auth.auth().signIn(with: credential) { [unowned self] result, error in
                   GIDSignIn.sharedInstance.signOut()
                   
                   if let error = error {
                       // Handle sign in with credential error...
                       print("Error signing in with credential: \(error.localizedDescription)")
                       return
                   }
                   
                   // Successfully signed in.
                   self.checkDuplicateEmail(user) // Check for duplicate email.
               }
           }
    }
    
    func checkDuplicateEmail(_ user: GIDGoogleUser) {
        let email = user.profile?.email
        
        if let email = email {
            // Check if the email already exists in Firebase.
            Auth.auth().fetchSignInMethods(forEmail: email) { [unowned self] signInMethods, error in
                if let error = error {
                    // Handle fetch sign in methods error...
                    print("Error fetching sign-in methods: \(error.localizedDescription)")
                    return
                }

                if let signInMethods = signInMethods, signInMethods.count > 0 {
                    // Email already exists, show alert.
                    self.showDuplicateEmailAlert()
                } else {
                    // Email doesn't exist, proceed with navigation or other actions.
                    self.navigation()
                }
            }
        } else {
            // Email is not provided in the Google user profile.
            // Handle this case as needed.
            print("Email is not provided in the Google user profile.")
        }
    }

    func showDuplicateEmailAlert() {
        let alert = UIAlertController(title: "Email Already Exists",
                                      message: "The email associated with this Google account already exists.",
                                      preferredStyle: .alert)

        let okAction = UIAlertAction(title: "OK", style: .default) { _ in
            // Handle OK action if needed.
        }

        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
        KakaoLogin.addTarget(self, action: #selector(kakaoLoginButtonTapped), for: .touchUpInside)
        
      
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        GIDSignIn.sharedInstance.signOut()
    }
    
    @objc private func kakaoLoginButtonTapped(_ sender: UIButton) {

//        // 카카오 토큰이 존재한다면
//        if AuthApi.hasToken() {
//            UserApi.shared.accessTokenInfo { accessTokenInfo, error in
//                if let error = error {
//                    print("DEBUG: 카카오톡 토큰 가져오기 에러 \(error.localizedDescription)")
//                    self.kakaoLogin()
//                } else {
//                    // 토큰 유효성 체크 성공 (필요 시 토큰 갱신됨)
//                    self.naviagtion()
//                }
//            }
//        } else {
//            // 토큰이 없는 상태 로그인 필요
//            kakaoLogin()
//        }
        kakaoLogin()
    }
    
    
    
    private func rootView() {
        let tabbar = UIStoryboard.init(name: "Main", bundle: nil)
            guard let mainView = tabbar.instantiateViewController(withIdentifier: "TabBarViewController") as? TabBarViewController else {return}
              (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootVC(mainView, animated: false)
    }

    private func kakaoLogin() {

        if UserApi.isKakaoTalkLoginAvailable() {
            kakaoLoginInApp() // 카카오톡 앱이 있다면 앱으로 로그인
        } else {
            kakaoLoginInWeb() // 앱이 없다면 웹으로 로그인 (시뮬레이터)
        }
    }
    
    private func kakaoLoginInApp() {

        UserApi.shared.loginWithKakaoTalk { oauthToken, error in
            if let error = error {
                print("DEBUG: 카카오톡 로그인 에러 \(error.localizedDescription)")
            } else {
                print("DEBUG: 카카오톡 로그인 Success")
                if let token = oauthToken {
                    print("DEBUG: 카카오톡 토큰 \(token)")
                    self.loginInFirebase()
                }
            }
        }
    }
    


    private func loginInFirebase() {
        UserApi.shared.me() { user, error in
            if let error = error {
                print("DEBUG: 카카오톡 사용자 정보가져오기 에러 \(error.localizedDescription)")
            } else {
                print("DEBUG: 카카오톡 사용자 정보가져오기 success.")
                // 파이어베이스 유저 생성 (이메일로 회원가입)
                Auth.auth().createUser(withEmail: (user?.kakaoAccount?.email)!,
                                       password: "\(String(describing: user?.id))") { result, error in
                    if let error = error {
                        print("DEBUG: 파이어베이스 사용자 생성 실패 \(error.localizedDescription)")
                        // Firebase에 이미 계정이 존재하는 경우 에러 메시지를 표시하는 알림창 생성
                        let alert = UIAlertController(title: "중복된 이메일 입니다.",
                                                      message: "다시 입력해 주세요",
                                                      preferredStyle: .alert)
                        let okAction = UIAlertAction(title: "확인", style: .default)
                        alert.addAction(okAction)
                        self.present(alert, animated: true, completion: nil)
                    } else {
                        print("DEBUG: 파이어베이스 사용자 생성")
                        Auth.auth().signIn(withEmail: (user?.kakaoAccount?.email)!,
                                           password: "\(String(describing: user?.id))")
                        
                        self.emailData = "\(String(describing: user?.kakaoAccount?.email))"
                        self.passwordData = "\(String(describing: user?.id))"
                        
                        self.navigation()   // 회원가입 화면으로 이동
                    }
                }
            }
        }
    }

    
    private func kakaoLoginInWeb() {

        UserApi.shared.loginWithKakaoAccount { oauthToken, error in
            if let error = error {
                print("DEBUG: 카카오톡 로그인 에러 \(error.localizedDescription)")
            } else {
                print("DEBUG: 카카오톡 로그인 Success")
                if let token = oauthToken {
                    print("DEBUG: 카카오톡 토큰 \(token)")
                    self.loginInFirebase()
                }
            }
        }
    }

    
    private func navigation() {
        let VC = self.storyboard?.instantiateViewController(identifier: "AgreementViewController") as! AgreementViewController
        VC.modalPresentationStyle = .fullScreen
        
        self.navigationController?.pushViewController(VC, animated: true)
        self.dismiss(animated: true)
    }
    
    public func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
      if let error = error {    // 에러 처리
        print("ERROR Google Sign In \(error.localizedDescription)")
        return
      }

     
    }
    
}

//extension SignUpViewController: ASAuthorizationControllerDelegate {
//    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
//        if let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential {
//            guard let nonce = currentNonce else {
//                fatalError("Invalid state: A login callback was received, but no login request was sent.")
//            }
//            guard let appleIDToken = appleIDCredential.identityToken else {
//                print("Unable to fetch identity token")
//                return
//            }
//            guard let idTokenString = String(data: appleIDToken, encoding: .utf8) else {
//                print("Unable to serialize token string from data: \(appleIDToken.debugDescription)")
//                return
//            }
//
//            let credential = OAuthProvider.credential(withProviderID: "apple.com", idToken: idTokenString, rawNonce: nonce)
//
//            Auth.auth().signIn(with: credential) { authResult, error in
//                if let error = error {
//                    print ("Error Apple sign in: %@", error)
//                    let alert = UIAlertController(title: "Email Already Exists",
//                                                                              message: "The email associated with this Apple account already exists.",
//                                                                              preferredStyle: .alert)
//                    let okAction = UIAlertAction(title: "OK", style: .default) { _ in
//                                                    // Handle OK action if needed.
//                                                }
//                    alert.addAction(okAction)
//                    self.present(alert, animated: true, completion: nil)
//                    return
//                }
//                // User is signed in to Firebase with Apple.
//                // ...
//                self.navigation()
//            }
//        }
//    }
//}

//extension SignUpViewController: ASAuthorizationControllerDelegate {
//    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
//        if let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential {
//            guard let nonce = currentNonce else {
//                fatalError("Invalid state: A login callback was received, but no login request was sent.")
//            }
//            guard let appleIDToken = appleIDCredential.identityToken else {
//                print("Unable to fetch identity token")
//                return
//            }
//            guard let idTokenString = String(data: appleIDToken, encoding: .utf8) else {
//                print("Unable to serialize token string from data: \(appleIDToken.debugDescription)")
//                return
//            }
//
//            let credential = OAuthProvider.credential(withProviderID: "apple.com", idToken: idTokenString, rawNonce: nonce)
//
//            Auth.auth().signIn(with: credential) { authResult, error in
//                if let error = error as NSError?, error.code == AuthErrorCode.emailAlreadyInUse.rawValue {
//                    let alert = UIAlertController(title: "Email Already Exists",
//                                                  message: "The email associated with this Apple account already exists.",
//                                                  preferredStyle: .alert)
//                    let okAction = UIAlertAction(title: "OK", style: .default) { _ in
//                        // Handle OK action if needed.
//                    }
//                    alert.addAction(okAction)
//                    DispatchQueue.main.async {
//                        self.present(alert, animated: true, completion: nil)
//                    }
//                } else if let error = error {
//                    print("Error Apple sign in:", error.localizedDescription)
//                } else {
//                    // User is signed in to Firebase with Apple.
//                    // ...
//                    self.navigation()
//                }
//            }
//        }
//    }
//}

//extension SignUpViewController: ASAuthorizationControllerDelegate {
//    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
//        if let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential {
//            guard let nonce = currentNonce else {
//                fatalError("Invalid state: A login callback was received, but no login request was sent.")
//            }
//            guard let appleIDToken = appleIDCredential.identityToken else {
//                print("Unable to fetch identity token")
//                return
//            }
//            guard let idTokenString = String(data: appleIDToken, encoding: .utf8) else {
//                print("Unable to serialize token string from data: \(appleIDToken.debugDescription)")
//                return
//            }
//
//            let credential = OAuthProvider.credential(withProviderID: "apple.com", idToken: idTokenString, rawNonce: nonce)
//
//            // Check if the email is already in use
//            Auth.auth().fetchSignInMethods(forEmail: appleIDCredential.email ?? "") { [unowned self] methods, error in
//                if let error = error {
//                    print("Error fetching sign-in methods:", error.localizedDescription)
//                    return
//                }
//
//                if let methods = methods, methods.contains("password") {
//                    // Email is already in use, show alert
//                    let alert = UIAlertController(title: "Email Already Exists",
//                                                  message: "The email associated with this Apple account already exists.",
//                                                  preferredStyle: .alert)
//                    let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
//                    alert.addAction(okAction)
//                    DispatchQueue.main.async {
//                        self.present(alert, animated: true, completion: nil)
//                    }
//                    return
//                }
//
//                // Email is not in use, proceed with sign-in
//                Auth.auth().signIn(with: credential) { [unowned self] authResult, error in
//                    if let error = error {
//                        print("Error Apple sign in:", error.localizedDescription)
//                        return
//                    }
//                    // User is signed in to Firebase with Apple.
//                    // ...
//                    self.navigation()
//                }
//            }
//        }
//    }
//}

extension SignUpViewController: ASAuthorizationControllerDelegate {
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        if let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential {
            guard let nonce = currentNonce else {
                fatalError("Invalid state: A login callback was received, but no login request was sent.")
            }
            guard let appleIDToken = appleIDCredential.identityToken else {
                print("Unable to fetch identity token")
                return
            }
            guard let idTokenString = String(data: appleIDToken, encoding: .utf8) else {
                print("Unable to serialize token string from data: \(appleIDToken.debugDescription)")
                return
            }

            let credential = OAuthProvider.credential(withProviderID: "apple.com", idToken: idTokenString, rawNonce: nonce)

            Auth.auth().signIn(with: credential) { authResult, error in
                if let error = error as NSError?, error.code == AuthErrorCode.emailAlreadyInUse.rawValue {
                    let alert = UIAlertController(title: "Email Already Exists",
                                                  message: "The email associated with this Apple account already exists.",
                                                  preferredStyle: .alert)
                    let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                    alert.addAction(okAction)
                    DispatchQueue.main.async {
                        self.present(alert, animated: true, completion: nil)
                    }
                } else if let error = error {
                    print("Error Apple sign in:", error.localizedDescription)
                } else {
                    // User is signed in to Firebase with Apple.
                    // ...
                    self.navigation()
                }
            }
        }
    }
}



//Apple Sign in
extension SignUpViewController {
    func startSignInWithAppleFlow() {
        let nonce = randomNonceString()
        currentNonce = nonce
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        let request = appleIDProvider.createRequest()
        request.requestedScopes = [.fullName, .email]
        request.nonce = sha256(nonce)
        
        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        authorizationController.delegate = self
        authorizationController.presentationContextProvider = self
        authorizationController.performRequests()
    }
    
    private func sha256(_ input: String) -> String {
        let inputData = Data(input.utf8)
        let hashedData = SHA256.hash(data: inputData)
        let hashString = hashedData.compactMap {
            return String(format: "%02x", $0)
        }.joined()
        
        return hashString
    }
    
    // Adapted from https://auth0.com/docs/api-auth/tutorials/nonce#generate-a-cryptographically-random-nonce
    private func randomNonceString(length: Int = 32) -> String {
        precondition(length > 0)
        let charset: Array<Character> =
            Array("0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._")
        var result = ""
        var remainingLength = length
        
        while remainingLength > 0 {
            let randoms: [UInt8] = (0 ..< 16).map { _ in
                var random: UInt8 = 0
                let errorCode = SecRandomCopyBytes(kSecRandomDefault, 1, &random)
                if errorCode != errSecSuccess {
                    fatalError("Unable to generate nonce. SecRandomCopyBytes failed with OSStatus \(errorCode)")
                }
                return random
            }
            
            randoms.forEach { random in
                if remainingLength == 0 {
                    return
                }
                
                if random < charset.count {
                    result.append(charset[Int(random)])
                    remainingLength -= 1
                }
            }
        }
        
        return result
    }
}

extension SignUpViewController : ASAuthorizationControllerPresentationContextProviding {
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return self.view.window!
    }
}
