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

class SignUpViewController: UIViewController, GIDSignInDelegate {
   
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
    
    @IBAction func googleLoginBtn(_ sender: UIButton) {
        GIDSignIn.sharedInstance().signIn()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
        GIDSignIn.sharedInstance().clientID = FirebaseApp.app()?.options.clientID
        GIDSignIn.sharedInstance().delegate = self
        KakaoLogin.addTarget(self, action: #selector(kakaoLoginButtonTapped), for: .touchUpInside)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        firebaseAuth()
        GIDSignIn.sharedInstance().presentingViewController = self
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    @objc private func kakaoLoginButtonTapped(_ sender: UIButton) {

        // 카카오 토큰이 존재한다면
        if AuthApi.hasToken() {
            UserApi.shared.accessTokenInfo { accessTokenInfo, error in
                if let error = error {
                    print("DEBUG: 카카오톡 토큰 가져오기 에러 \(error.localizedDescription)")
                    self.kakaoLogin()
                } else {
                    // 토큰 유효성 체크 성공 (필요 시 토큰 갱신됨)
                    self.naviagtion()
                }
            }
        } else {
            // 토큰이 없는 상태 로그인 필요
            kakaoLogin()
        }
    }
    
    private func firebaseAuth() {
        
        if Auth.auth().currentUser != nil {
            self.rootView()
        } else {
          // No user is signed in.
          // ...
        }
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
                        Auth.auth().signIn(withEmail: (user?.kakaoAccount?.email)!,
                                           password: "\(String(describing: user?.id))")
                        //alet 사용
                        
                        //self.didSendEventClosure?(.close)
                    } else {
                        print("DEBUG: 파이어베이스 사용자 생성")
                        Auth.auth().signIn(withEmail: (user?.kakaoAccount?.email)!,
                                           password: "\(String(describing: user?.id))")
                        
                        self.emailData = "\(String(describing: user?.kakaoAccount?.email))"
                        self.passwordData = "\(String(describing: user?.id))"
                        self.naviagtion()   // 회원가입 화면으로 이동
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

    
    private func naviagtion() {
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

      // 사용자 인증값 가져오기
      guard let authentication = user.authentication else { return }
      let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken, accessToken: authentication.accessToken)

      // Firebase Auth에 인증정보 등록하기
      Auth.auth().signIn(with: credential) { _, _ in
        self.naviagtion()    // 메인 화면으로 이동
      }
    }
    
}

extension SignUpViewController: ASAuthorizationControllerDelegate {
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        if let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential {
            /*
             Nonce 란?
             - 암호화된 임의의 난수
             - 단 한번만 사용할 수 있는 값
             - 주로 암호화 통신을 할 때 활용
             - 동일한 요청을 짧은 시간에 여러번 보내는 릴레이 공격 방지
             - 정보 탈취 없이 안전하게 인증 정보 전달을 위한 안전장치
             */
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
                if let error = error {
                    print ("Error Apple sign in: %@", error)
                    return
                }
                // User is signed in to Firebase with Apple.
                // ...
                ///Main 화면으로 보내기
//                self.emailData = "\(String(describing: user?.kakaoAccount?.email))"
//                self.passwordData = "\(String(describing: user?.id))"
                self.naviagtion()
            }
        }
    }
}


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




